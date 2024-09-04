import 'package:flutter/material.dart';
import 'package:shop_hub/data/vos/product_vo.dart';
import 'package:shop_hub/network/product_data_agent.dart';
import 'package:shop_hub/network/product_data_agent_impl.dart';
import '../data/vos/category_vo.dart';

class HomeScreenProvider extends ChangeNotifier{
  bool _isDispose  = false;
  int _currentIndexPage = 0;

  List<CategoryVO> categories = [];
  List<ProductVO> flashSales = [];
  final ScrollController _scrollController = ScrollController();
  final ProductDataAgent _productDataAgent = ProductDataAgentImpl();
  ScrollController get scrollController =>_scrollController;
  int get currentIndexPage =>_currentIndexPage;


  set currentIndex(index){
    _currentIndexPage = index;
    notifyListeners();
  }

  Color iconColor = Colors.white;
  Color searchBoxColor = Colors.white;
  HomeScreenProvider(){
    _productDataAgent.fetchCategoryListStream().listen((event) {
      if(event != null){
        categories = event;
        notifyListeners();
      }
    });
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
          iconColor = _scrollController.offset >= 196
              ? Colors.grey
              : Colors.white;
          searchBoxColor = _scrollController.offset >= 196
              ? Colors.grey.withOpacity(0.2)
              : Colors.white;
      }
      notifyListeners();
    });

    /// fetch flash sale products
    _productDataAgent.fetchFlashSaleProductStream().listen((event) {
      if(event != null){
        flashSales = event ;
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _isDispose = true;
    super.dispose();
  }
  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    if(!_isDispose){
      super.notifyListeners();
    }
  }
}