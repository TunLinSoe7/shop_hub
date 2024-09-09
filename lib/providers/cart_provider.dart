import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_hub/data/vos/cart_vo.dart';
import 'package:shop_hub/data/vos/product_vo.dart';
import 'package:shop_hub/network/cart_data_agent.dart';
import 'package:shop_hub/network/cart_data_agent_impl.dart';
import 'package:toastification/toastification.dart';

class CartProvider extends ChangeNotifier {
  bool _isDispose = false;
 final CartDataAgent _cartDataAgent = CartDataAgentImpl();
 List<CartVO>? cartItems = [];
 CartProvider(){
   _cartDataAgent.fetchCartListStream().listen((event) {
     print('===============>${event?.length}');
     if(event!=null){
       cartItems = event;
       notifyListeners();
     }
   });
 }

 Future<void> addToCart(ProductVO productVO,int quantity)async{
   if(productVO.stock == 0){
     showToastificationItem(title: 'Out Of Stock', type: ToastificationType.warning,
         bgColor: Colors.amber.shade100,
         borderColor: Colors.amber, iconColor: Colors.black, iconData: Iconsax.info_circle);
     return;
   }else if(quantity == 0){
     showToastificationItem(title: 'Selected Quantity', type: ToastificationType.warning,
         bgColor: Colors.amber.shade100,
         borderColor: Colors.amber, iconColor: Colors.black, iconData: Iconsax.info_circle);
     return;
   }
   CartVO cartVO = CartVO(
       productQuantity: quantity,
       productId: productVO.productId,
       name: productVO.name,
       price: productVO.price,
       imageUrl: productVO.image,
   );
   await _cartDataAgent.addToCart(cartVO,quantity);
   showToastificationItem(title: 'Added To Cart Successfully', type: ToastificationType.success,
       bgColor: Colors.green.shade100,
       borderColor: Colors.green, iconColor: Colors.black, iconData: Iconsax.tick_circle);
   notifyListeners();
 }
 Future<void> increaseProduct(CartVO cartVO)async{
   await _cartDataAgent.increaseCount(cartVO.productId ?? '');
   notifyListeners();
 }
 Future<void> decreaseProduct(CartVO cartVO)async{
   if(cartVO.productQuantity>1){
     await _cartDataAgent.decreaseCount(cartVO.productId ?? '');
   }else{
     _cartDataAgent.deleteFromCart(cartVO.productId ?? '');
   }
   notifyListeners();
 }
  @override
  void dispose() {
    _isDispose = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    if (!_isDispose) {
      super.notifyListeners();
    }
  }
}
ToastificationItem showToastificationItem ({
  required String title, required ToastificationType type,
  required Color bgColor,required Color borderColor,required Color iconColor,
  required IconData iconData
})=>  toastification.show(
    type: type,
    icon: Icon(iconData,color:iconColor ,),
    alignment: Alignment.topCenter,
    showProgressBar: false,
    backgroundColor: bgColor,
    borderSide: BorderSide(
        color: borderColor
    ),
    style: ToastificationStyle.flat,
    autoCloseDuration: const Duration(seconds: 5),
    title: Text(title,style: const TextStyle(
        color: Colors.black
    ),)
);