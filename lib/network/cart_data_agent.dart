import 'package:shop_hub/data/vos/cart_vo.dart';

abstract class CartDataAgent{
  Future addToCart(CartVO cartVO,int quantity);
  Future deleteFromCart(String productId);
  Future increaseCount(String productId);
  Future decreaseCount(String productId);
  Stream<List<CartVO>?> fetchCartListStream();
}