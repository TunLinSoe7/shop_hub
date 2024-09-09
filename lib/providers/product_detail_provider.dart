import 'package:flutter/material.dart';
import 'package:shop_hub/data/vos/product_vo.dart';
import 'package:shop_hub/network/product_data_agent.dart';
import 'package:shop_hub/network/product_data_agent_impl.dart';

class ProductDetailProvider extends ChangeNotifier{
  bool _isDispose = false;
  ProductVO? productVO;
  List<ProductVO>? relatedProducts = [];
  int quantity = 0;
  void increase(int newQuantity){
    quantity = newQuantity+1;
    notifyListeners();
  }
  void decrease(int newQuantity){
    if(quantity > 0 ){
      quantity = newQuantity-1;
      notifyListeners();
    }
  }
  final ProductDataAgent _productDataAgent = ProductDataAgentImpl();
  /// fetch product by id from firestore
  ProductDetailProvider(String id,String category){
    _productDataAgent.fetchProductByIdStream(id).then((value) {
      productVO = value;
      notifyListeners();
    } );
    /// fetch related products
    _productDataAgent.fetchProductByCategory(category).listen((event) {
      relatedProducts = event;
      notifyListeners();
    });
  }
  @override
  void notifyListeners() {
    if(!_isDispose){
      super.notifyListeners();
    }
  }
  @override
  void dispose() {
    _isDispose = true;
    super.dispose();
  }
}