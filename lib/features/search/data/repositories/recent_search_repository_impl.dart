import 'package:ecommerce_app/features/search/data/data_source/local_data_sources/local_recent_search_data_source.dart';
import 'package:ecommerce_app/features/search/domain/repositories/recent_search_repository.dart';

class RecentSearchRepositoryImpl implements RecentSearchRepository {
  final LocalRecentSearchesDataSource localDataSource;
  RecentSearchRepositoryImpl({required this.localDataSource});
  @override
  Future<void> addSearch(String query) async {
    return await localDataSource.addSearch(query);
  }

  @override
  Future<void> clearAll() async {
    return await localDataSource.clearAll();
  }

  @override
  Future<List<String>> getRecentSearches() async {
    return await localDataSource.getRecentSearches();
  }
}
