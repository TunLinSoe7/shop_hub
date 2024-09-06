import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_hub/data/vos/category_vo.dart';
import 'package:shop_hub/data/vos/product_vo.dart';
import 'package:shop_hub/network/product_data_agent.dart';

class ProductDataAgentImpl extends ProductDataAgent{
  ProductDataAgentImpl._();
  static final ProductDataAgentImpl _singleton = ProductDataAgentImpl._();
  factory ProductDataAgentImpl()=>_singleton;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<List<CategoryVO>?> fetchCategoryListStream() {
    try{
      return _firebaseFirestore.collection('categories')
          .snapshots()
          .map((querySnapshot) {
            return querySnapshot.docs.map((documentSnapshot) => CategoryVO.fromJson(documentSnapshot.data())).toList();
      });
    }catch(e){
      throw Exception(e.toString());
    }
  }

  @override
  Stream<List<ProductVO>?> fetchProductByCategory(String category) {
    try{
      return _firebaseFirestore.collection('products')
          .where('category',isEqualTo: category)
          .snapshots()
          .map((event) => event.docs.map((e) => ProductVO.fromJson(e.data())).toList());
    }catch(e){
      throw Exception(e.toString());
    }
    }
 /// fetch flash sale products
  @override
  Stream<List<ProductVO>?> fetchFlashSaleProductStream() =>_firebaseFirestore.collection('products')
      .where('isFlashSale',isEqualTo: true)
      .snapshots()
      .map((event) => event.docs.map((e) => ProductVO.fromJson(e.data())).toList());

  @override
  Stream<List<ProductVO>?> fetchFashionsProductStream()=>_firebaseFirestore.collection('products')
      .where('category',isEqualTo: 'Fashions')
      .snapshots()
      .map((event) => event.docs.map((e) => ProductVO.fromJson(e.data())).toList());

  @override
  Future<ProductVO?> fetchProductByIdStream(String id) =>_firebaseFirestore
      .collection('products')
      .doc(id)
      .get().then((value) => ProductVO.fromJson(value.data() as Map<String,dynamic>));
}