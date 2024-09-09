import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_hub/data/vos/cart_vo.dart';
import 'package:shop_hub/network/cart_data_agent.dart';

class CartDataAgentImpl extends CartDataAgent{
  CartDataAgentImpl._();
  static final CartDataAgentImpl _singleton = CartDataAgentImpl._();
  factory CartDataAgentImpl()=>_singleton;
  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('users');

  /// add to cart
  @override
  Future addToCart(CartVO cartVO,int quantity)async {
    var user = FirebaseAuth.instance.currentUser;
    try{
      await collectionReference.doc(user?.uid)
          .collection('cart')
          .doc(cartVO.productId)
          .update({
        'product_quantity':FieldValue.increment(quantity),
        'productId': cartVO.productId,
      });
    }on FirebaseException catch(e){
      if(e.code == "not-found"){
        await collectionReference.doc(user?.uid)
            .collection('cart')
            .doc(cartVO.productId)
            .set({
          "productId":cartVO.productId,
          "name":cartVO.name,
          "imageUrl":cartVO.imageUrl,
          "price":cartVO.price,
          "product_quantity":quantity
            });
      }
    }
  }
  /// delete from cart
  @override
  Future deleteFromCart(String productId) async{
    var user = FirebaseAuth.instance.currentUser;
    await collectionReference.doc(user?.uid)
        .collection('cart')
        .doc(productId)
        .delete();
  }

  @override
  Stream<List<CartVO>?> fetchCartListStream() {
    try{
      var currentUserId = FirebaseAuth.instance.currentUser?.uid;
      return collectionReference
          .doc(currentUserId)
          .collection('cart')
          .snapshots()
          .map((event) => event.docs.map((e) => CartVO.fromJson(e.data())).toList());
    }catch(e){
      throw Exception(e.toString());
    }
  }

  @override
  Future increaseCount(String productId)async {
    var user = FirebaseAuth.instance.currentUser;
    await collectionReference.doc(user?.uid)
    .collection('cart')
    .doc(productId)
    .update({'product_quantity':FieldValue.increment(1)});
  }

  @override
  Future decreaseCount(String productId) async{
    var user = FirebaseAuth.instance.currentUser;
    await collectionReference.doc(user?.uid)
        .collection('cart')
        .doc(productId)
        .update({'product_quantity':FieldValue.increment(-1)});
  }
}