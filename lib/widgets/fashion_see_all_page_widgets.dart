import 'package:flutter/material.dart';
import 'package:shop_hub/providers/see_all_flash_sale_provider.dart';
import '../providers/fashion_all_provider.dart';
import '../utils/item_views/grid_product_item_views.dart';
import '../utils/item_views/list_product_item_view.dart';

class ShowProductIsListOrGridWidget extends StatelessWidget {
  const ShowProductIsListOrGridWidget({
    super.key, required this.provider,
  });
  final SellAllFashionProvider provider;


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: provider.currentIndex == 0
          ? GridView.builder(
          itemCount: provider.fashions.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.7, crossAxisCount: 2),
          itemBuilder: (_, index) {
            final product = provider.fashions[index];
            return GridProductItemView(
              onTap: (){},
              isFlashSale: product.isFlashSale ?? false,
              image: product.image,
              name: product.name,
              price: '${product.price}',
              flashSalePrice: '${product.price}',
            );
          })
          : ListView.builder(
          itemCount: provider.fashions.length,
          itemBuilder: (_, index) {
            final product = provider.fashions[index];
            return ListProductItemView(
                title: product.name ?? '',
                image: product.image ?? '',
                promoPrice: '${product.price}',
                isFlashSale: product.isFlashSale ??false,
                originalPrice: '${product.price}');
          }),
    );
  }
}

class ShowFlashSaleProductIsListOrGridWidget extends StatelessWidget {
  const ShowFlashSaleProductIsListOrGridWidget({
    super.key, required this.provider,
  });
  final SellAllFlashSaleProvider provider;


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: provider.currentIndex == 0
          ? GridView.builder(
          itemCount: provider.flashSales.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.7, crossAxisCount: 2),
          itemBuilder: (_, index) {
            final product = provider.flashSales[index];
            return GridProductItemView(
              onTap: (){},
              isFlashSale: product.isFlashSale ?? false,
              image: product.image,
              name: product.name,
              price: '${product.price}',
              flashSalePrice: '${product.price}',
            );
          })
          : ListView.builder(
          itemCount: provider.flashSales.length,
          itemBuilder: (_, index) {
            final product = provider.flashSales[index];
            return ListProductItemView(
                title: product.name ?? '',
                image: product.image ?? '',
                promoPrice: '${product.price}',
                isFlashSale: product.isFlashSale ??false,
                originalPrice: '${product.price}');
          }),
    );
  }
}