// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductVO _$ProductVOFromJson(Map<String, dynamic> json) => ProductVO(
      productId: json['productId'] as String?,
      category: json['category'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toInt(),
      isFlashSale: json['isFlashSale'] as bool?,
    );

Map<String, dynamic> _$ProductVOToJson(ProductVO instance) => <String, dynamic>{
      'productId': instance.productId,
      'category': instance.category,
      'name': instance.name,
      'image': instance.image,
      'description': instance.description,
      'price': instance.price,
      'isFlashSale': instance.isFlashSale,
    };
