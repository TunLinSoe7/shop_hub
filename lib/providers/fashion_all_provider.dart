import 'package:flutter/material.dart';
import 'package:shop_hub/data/vos/product_vo.dart';
import 'package:shop_hub/network/product_data_agent.dart';
import 'package:shop_hub/network/product_data_agent_impl.dart';

class SellAllFashionProvider extends ChangeNotifier{
  bool _isDispose  = false;

  List<ProductVO> fashions = [];
  final ProductDataAgent _productDataAgent = ProductDataAgentImpl();


  SellAllFashionProvider(){
    /// fetch flash sale products
    _productDataAgent.fetchFashionsProductStream().listen((event) {
      if(event != null){
        fashions = event ;
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