import 'package:flutter/material.dart';
import 'package:shop_hub/data/vos/product_vo.dart';
import 'package:shop_hub/network/product_data_agent.dart';
import 'package:shop_hub/network/product_data_agent_impl.dart';

class SellAllFlashSaleProvider extends ChangeNotifier{
  bool _isDispose  = false;

  List<ProductVO> flashSales = [];
  final ProductDataAgent _productDataAgent = ProductDataAgentImpl();


  Color iconColor = Colors.white;
  Color searchBoxColor = Colors.white;
  SellAllFlashSaleProvider(){
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