import 'package:flutter/material.dart';
import 'package:shop_hub/data/vos/product_vo.dart';
import 'package:shop_hub/network/product_data_agent.dart';
import 'package:shop_hub/network/product_data_agent_impl.dart';

class SellAllFashionProvider extends ChangeNotifier {
  bool _isDispose = false;
  int _currentIndex = 0;
  String lowOrHighText = '';


  int get currentIndex => _currentIndex;

  void setIndex(int newIndex,BuildContext context) {
    _currentIndex = newIndex;
    Navigator.of(context).pop();
    notifyListeners();
  }

  List<ProductVO> fashions = [];
  final ProductDataAgent _productDataAgent = ProductDataAgentImpl();
  void sortPriceLowToHigh(){
    fashions.sort((a,b)=>a.price!.compareTo(b.price ?? 0));
    notifyListeners();
  }
  void sortPriceHighToLow(){
    fashions.sort((a,b)=>b.price!.compareTo(a.price ?? 0));
    notifyListeners();
  }

  SellAllFashionProvider() {
    // Fetch flash sale products
    _productDataAgent.fetchFashionsProductStream().listen((event) {
      if (event != null) {
        fashions = event;
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
    if (!_isDispose) {
      super.notifyListeners();
    }
  }
}
