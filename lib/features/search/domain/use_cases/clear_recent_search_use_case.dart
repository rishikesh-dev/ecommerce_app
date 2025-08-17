import 'package:ecommerce_app/features/search/domain/repositories/recent_search_repository.dart';

class ClearRecentSearchUseCase {
  final RecentSearchRepository recentSearchRepository;

  ClearRecentSearchUseCase(this.recentSearchRepository);

  Future<void> call() async {
    await recentSearchRepository.clearAll();
  }
}