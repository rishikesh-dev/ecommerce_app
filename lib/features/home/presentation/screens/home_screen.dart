import 'package:ecommerce_app/features/home/data/models/category_model.dart';
import 'package:ecommerce_app/features/home/presentation/blocs/bloc/category_bloc/category_bloc.dart';
import 'package:ecommerce_app/features/home/presentation/blocs/product_bloc/product_bloc.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/product_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchProductsEvent());
    context.read<CategoryBloc>().add(FetchCategoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppBarWidget(
            controller: TextEditingController(),
            title: 'Discover',
            isFilter: true,
            onPressed: () {},
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
                      child: Text('Error loading categories: $state'),
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
                          onTap: () {},
                          child: Card(
                            color: Theme.of(context).scaffoldBackgroundColor,
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
                              child: Center(child: Text(category[index].name)),
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
            sliver: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (state is ProductError) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text('Error loading products: ${state.message}'),
                    ),
                  );
                }

                if (state is ProductLoaded) {
                  return SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final product = state.products[index];
                      return ProductCard(product: product);
                    }, childCount: state.products.length),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.7,
                        ),
                  );
                }

                return const SliverFillRemaining(
                  child: Center(child: Text('No products found')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
