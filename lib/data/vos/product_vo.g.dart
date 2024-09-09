// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductVO _$ProductVOFromJson(Map<String, dynamic> json) => ProductVO(
      category: json['category'] as String?,
      name: json['name'] as String?,
      searchName: json['search_name'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toInt(),
      stock: (json['stock'] as num?)?.toInt(),
      isFlashSale: json['isFlashSale'] as bool?,
      productId: json['productId'] as String?,
    );

Map<String, dynamic> _$ProductVOToJson(ProductVO instance) => <String, dynamic>{
      'productId': instance.productId,
      'category': instance.category,
      'search_name': instance.searchName,
      'name': instance.name,
      'image': instance.image,
      'description': instance.description,
      'price': instance.price,
      'stock': instance.stock,
      'isFlashSale': instance.isFlashSale,
    };
