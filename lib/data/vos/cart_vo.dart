import 'package:json_annotation/json_annotation.dart';
part 'cart_vo.g.dart';

@JsonSerializable()
class CartVO{
  @JsonKey(name: 'productId')
  final String? productId;
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'product_quantity')
  int productQuantity;

  CartVO({this.productId,required this.productQuantity,this.imageUrl, this.price, this.name});
  factory CartVO.fromJson(Map<String,dynamic> json)=>_$CartVOFromJson(json);
  Map<String,dynamic> toJson()=>_$CartVOToJson(this);
}