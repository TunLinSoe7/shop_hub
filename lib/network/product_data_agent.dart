import 'package:shop_hub/data/vos/category_vo.dart';
import 'package:shop_hub/data/vos/product_vo.dart';

abstract class ProductDataAgent{
  /// Fetch Categories List
  Stream<List<CategoryVO>?> fetchCategoryListStream();
  /// Fetch Product By Category
  Stream<List<ProductVO>?> fetchProductByCategory(String category);
  /// Fetch FlashSale Products
  Stream<List<ProductVO>?> fetchFlashSaleProductStream();
  /// Fetch Fashion Products
  Stream<List<ProductVO>?> fetchFashionsProductStream();
  /// Fetch Product By Id
  Future<ProductVO?> fetchProductByIdStream(String id);
  /// search product
  Stream<List<ProductVO>?> searchProducts(String searchTerm);

}