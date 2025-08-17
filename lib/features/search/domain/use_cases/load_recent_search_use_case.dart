import 'package:ecommerce_app/features/search/domain/repositories/recent_search_repository.dart';

class LoadRecentSearchUseCase {
  final RecentSearchRepository recentSearchRepository;

  LoadRecentSearchUseCase({required this.recentSearchRepository});

  Future<List<String>> call() async {
    return await recentSearchRepository.getRecentSearches();
  }
}
