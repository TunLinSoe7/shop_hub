// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartVO _$CartVOFromJson(Map<String, dynamic> json) => CartVO(
      productId: json['productId'] as String?,
      name: json['name'] as String?,
      price: json['price'] ?? 0,
      imageUrl: json['imageUrl'] as String?,
      productQuantity: json['product_quantity'] ?? 0,
    );

Map<String, dynamic> _$CartVOToJson(CartVO instance) => <String, dynamic>{
      'productId': instance.productId,
      'name':instance.name,
      'price':instance.price,
      'imageUrl':instance.imageUrl,
      'product_quantity': instance.productQuantity,
    };
