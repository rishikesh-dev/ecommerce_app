import 'package:ecommerce_app/features/home/data/models/category_model.dart';
import 'package:ecommerce_app/features/home/presentation/blocs/bloc/category_bloc/category_bloc.dart';
import 'package:ecommerce_app/features/home/presentation/blocs/product_bloc/product_bloc.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/product_card.dart';
import 'package:ecommerce_app/features/search/presentation/blocs/search_blocs/bloc/search_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {});
      context.read<SearchBloc>().add(
        SearchQueryChangedEvent(searchController.text.trim()),
      );
    });

    context.read<ProductBloc>().add(FetchProductsEvent());
    context.read<CategoryBloc>().add(FetchCategoryEvent());
  }

  String selectedCategory = 'all';
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppBarWidget(
            controller: searchController,
            title: 'Discover',
            isFilter: true,
            suffixIcon: ValueListenableBuilder(
              valueListenable: searchController,
              builder: (context, value, child) {
                return value.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          searchController.clear();
                          context.read<SearchBloc>().add(
                            SearchResultsClearEvent(),
                          );
                        },
                      )
                    : SizedBox();
              },
            ),
            onPressed: () {
              context.read<SearchBloc>().add(
                SearchQueryChangedEvent(searchController.text),
              );
            },
          ),

          // Horizontal category list
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is CategoryError) {
                    if (kDebugMode) {
                      print(state.message);
                    }
                    return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Something went wrong'),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              context.read<CategoryBloc>().add(
                                FetchCategoryEvent(),
                              );
                            },
                            child: Text(
                              'Click to refresh',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is CategoryLoaded) {
                    final category = [
                      CategoryModel(name: 'All', slug: 'all', url: 'all'),
                      ...state.categories,
                    ];
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: category.length,
                      itemBuilder: (context, index) {
                        category.add;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = category[index].slug;
                            });
                            if (selectedCategory == 'all') {
                              context.read<ProductBloc>().add(
                                FetchProductsEvent(),
                              );
                            } else {
                              context.read<ProductBloc>().add(
                                FetchProductByCategory(
                                  category: category[index].slug,
                                ),
                              );
                            }
                          },
                          child: Card(
                            color: selectedCategory == category[index].slug
                                ? Theme.of(context).cardColor
                                : Theme.of(context).scaffoldBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.outline,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                              ),
                              child: Center(
                                child: Text(
                                  category[index].name,
                                  style: TextStyle(
                                    color:
                                        selectedCategory == category[index].slug
                                        ? Theme.of(
                                            context,
                                          ).scaffoldBackgroundColor
                                        : Theme.of(context).cardColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return SizedBox();
                },
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is SearchLoaded && state.results.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(child: Text('No products found')),
                  );
                }
                if (state is SearchLoaded) {
                  return SliverAlignedGrid(
                    itemCount: state.results.length,
                    itemBuilder: (ctx, index) =>
                        ProductCard(product: state.results[index]),
                    gridDelegate:
                        SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                  );
                }
                if (state is SearchError) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Something went wrong'),
                          TextButton(
                            onPressed: () {
                              context.read<SearchBloc>().add(
                                SearchQueryChangedEvent(searchController.text),
                              );
                              setState(() {});
                            },
                            child: Text('Click to refresh'),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const SliverFillRemaining(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (state is ProductLoaded) {
                      return SliverAlignedGrid(
                        itemCount: state.products.length,
                        itemBuilder: (ctx, index) =>
                            ProductCard(product: state.products[index]),
                        gridDelegate:
                            SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                      );
                    }
                    if (state is ProductError) {
                      return SliverFillRemaining(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Something went wrong'),
                              TextButton(
                                onPressed: () {
                                  context.read<ProductBloc>().add(
                                    FetchProductsEvent(),
                                  );
                                },
                                child: Text('Click to refresh'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const SliverFillRemaining(
                      child: Center(child: Text('No products found')),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
