import 'package:shop_hub/data/vos/category_vo.dart';
import 'package:shop_hub/data/vos/product_vo.dart';

abstract class ProductDataAgent{
  Stream<List<CategoryVO>?> fetchCategoryListStream();
  Stream<List<ProductVO>?> fetchProductByCategory(String category);
  Stream<List<ProductVO>?> fetchFlashSaleProductStream();
  Stream<List<ProductVO>?> fetchFashionsProductStream();
}