import 'package:json_annotation/json_annotation.dart';
part 'product_vo.g.dart';
@JsonSerializable()
class ProductVO{
  @JsonKey(name: 'productId')
  final String? productId;
  @JsonKey(name: 'category')
  final String? category;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'isFlashSale')
  final bool? isFlashSale;

  ProductVO({this.category,this.name,this.image,this.description,this.price,this.isFlashSale,this.productId});
  factory ProductVO.fromJson(Map<String,dynamic> json)=>_$ProductVOFromJson(json);
  Map<String,dynamic> toJson()=>_$ProductVOToJson(this);
}