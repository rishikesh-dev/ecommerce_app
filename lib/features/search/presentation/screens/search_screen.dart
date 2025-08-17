import 'package:ecommerce_app/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/product_card.dart';
import 'package:ecommerce_app/features/search/presentation/blocs/recent_search_bloc/bloc/recent_search_bloc.dart';
import 'package:ecommerce_app/features/search/presentation/blocs/search_blocs/bloc/search_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  List<String> filters = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<RecentSearchBloc>().add(LoadRecentSearchesEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppBarWidget(
            controller: _searchController,
            title: 'Search',
            suffixIcon: ValueListenableBuilder(
              valueListenable: _searchController,
              builder: (context, value, child) {
                return value.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          _searchController.clear();
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
                SearchQueryChangedEvent(_searchController.text),
              );
              context.read<RecentSearchBloc>().add(
                AddRecentSearchEvent(_searchController.text),
              );
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Searches',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      _searchController.clear();
                      context.read<RecentSearchBloc>().add(
                        ClearRecentSearchesEvent(),
                      );
                    },
                    child: Text(
                      'Clear All',
                      style: TextStyle(
                        color: Theme.of(context).cardColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (kDebugMode) {
                print(state);
              }
              if (state is SearchLoading) {
                return SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state is SearchLoaded) {
                if (kDebugMode) {
                  print(state.results.length);
                }
                if (state.results.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(child: Text('No results found')),
                  );
                }
                return SliverGrid.builder(
                  itemCount: state.results.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (ctx, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProductCard(product: state.results[index]),
                  ),
                );
              }

              if (state is SearchError) {
                if (kDebugMode) {
                  print(state.message);
                }
                return SliverToBoxAdapter(
                  child: Center(child: Text('Error: ${state.message}')),
                );
              }
              return BlocBuilder<RecentSearchBloc, RecentSearchState>(
                builder: (context, state) {
                  if (state is RecentSearchesLoaded) {
                    if (state.recentSearches.isEmpty) {
                      return SliverFillRemaining(
                        child: Center(child: Text('No recent searches')),
                      );
                    }
                    return SliverList.separated(
                      itemBuilder: (ctx, index) {
                        return ListTile(
                          title: Text(state.recentSearches[index]),
                        );
                      },
                      separatorBuilder: (ctx, index) => Divider(),
                      itemCount: state.recentSearches.length,
                    );
                  }
                  if (state is RecentSearchesError) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text('Something went wrong: ${state.message}'),
                      ),
                    );
                  }
                  return SliverFillRemaining(
                    child: Center(child: Text('No recent searches')),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
