import 'package:shared_preferences/shared_preferences.dart';

class LocalRecentSearchesDataSource {
  static const String _key = 'recent_searches';

  Future<List<String>> getRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  Future<void> addSearch(String query) async {
    if (query.trim().isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    final searches = prefs.getStringList(_key) ?? [];

    // Remove if exists to avoid duplicates, then insert at top
    searches.remove(query);
    searches.insert(0, query);

    // Keep only the latest 10 searches
    final limited = searches.take(10).toList();

    await prefs.setStringList(_key, limited);
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  Future<void> removeSearch(String query) async {
    final prefs = await SharedPreferences.getInstance();
    final searches = prefs.getStringList(_key) ?? [];
    searches.remove(query);
    await prefs.setStringList(_key, searches);
  }
}
