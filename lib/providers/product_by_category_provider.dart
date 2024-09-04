import 'package:flutter/material.dart';
import 'package:shop_hub/network/product_data_agent_impl.dart';
import '../data/vos/product_vo.dart';
import '../network/product_data_agent.dart';

class ProductByCategoryProvider extends ChangeNotifier{
  bool _isDispose  = false;

  List<ProductVO> products = [];
  final ProductDataAgent _productDataAgent = ProductDataAgentImpl();
  ProductByCategoryProvider(String category){
    _productDataAgent.fetchProductByCategory(category).listen((event) {
      if(event !=null){
        products = event;
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