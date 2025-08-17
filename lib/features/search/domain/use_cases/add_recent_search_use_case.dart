import 'package:ecommerce_app/features/search/domain/repositories/recent_search_repository.dart';

class AddRecentSearchUseCase {
  final RecentSearchRepository recentSearchRepository;
  AddRecentSearchUseCase(this.recentSearchRepository);
  Future<void> call(String query) async {
    await recentSearchRepository.addSearch(query);
  }
}
