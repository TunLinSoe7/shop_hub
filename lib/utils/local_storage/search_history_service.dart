import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryService {
  SearchHistoryService._();
  static final SearchHistoryService _singleton = SearchHistoryService._();
  factory SearchHistoryService()=>_singleton;

  static const _searchHistoryKey = 'search_history';

  Future<void> addSearchQuery(String query) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(_searchHistoryKey) ?? [];

    // Add the query to the list and remove duplicates
    if (history.contains(query)) {
      history.remove(query);
    }
    history.insert(0, query); // Add to the top of the list
    if (history.length > 10) {
      history.removeLast(); // Keep only the most recent 10 queries
    }

    await prefs.setStringList(_searchHistoryKey, history);
  }

  Future<List<String>> getSearchHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_searchHistoryKey) ?? [];
  }

  Future<void> clearSearchHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_searchHistoryKey);
  }
}
