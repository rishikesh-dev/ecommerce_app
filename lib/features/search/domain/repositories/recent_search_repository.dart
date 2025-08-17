abstract interface class RecentSearchRepository {
  Future<List<String>> getRecentSearches();
  Future<void> addSearch(String query);
  Future<void> clearAll();
}
