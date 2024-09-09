import 'package:flutter/material.dart';
import 'package:shop_hub/data/vos/product_vo.dart';
import 'package:shop_hub/network/product_data_agent.dart';
import 'package:shop_hub/network/product_data_agent_impl.dart';
import 'package:shop_hub/utils/local_storage/search_history_service.dart';

class SearchProvider extends ChangeNotifier {
  final ProductDataAgent _productDataAgent = ProductDataAgentImpl();
  final TextEditingController searchController = TextEditingController();
  final SearchHistoryService _historyService = SearchHistoryService();
  List<String> searchHistory = [];

  SearchProvider() {
    _loadSearchHistory();
  }

  Future<void> _loadSearchHistory() async {
    searchHistory = await _historyService.getSearchHistory();
    notifyListeners();
  }

  Future<void> addSearchHistory(String query) async {
    await _historyService.addSearchQuery(query);
    _loadSearchHistory(); // Refresh history
  }

  Future<void> removeSearchHistory(String query) async {
    searchHistory.remove(query);
    await _historyService.clearSearchHistory();
    notifyListeners();
  }

  List<ProductVO>? search = [];

  void setNullSearchList(String? value) {
    if (value == null || value.isEmpty) {
      search = [];
    }
    notifyListeners();
  }

  void searchProducts(String searchTerm) {
    _productDataAgent.searchProducts(searchTerm.toLowerCase().trim()).listen((event) {
      print('len==============>${event?.length}');
      if (event != null) {
        search = event;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
