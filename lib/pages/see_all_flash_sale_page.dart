import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shop_hub/providers/see_all_flash_sale_provider.dart';

import '../utils/item_views/grid_product_item_views.dart';

class SeeAllFlashSalePage extends StatelessWidget {
  const SeeAllFlashSalePage({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>SellAllFlashSaleProvider(),
      child: Consumer<SellAllFlashSaleProvider>(
        builder: (_,provider,__){
          return Scaffold(
            backgroundColor: Colors.white.withOpacity(0.96),
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Colors.black,
              actions: const [
                Icon(Icons.search,color: Colors.white,),
                SizedBox(width: 10,),
                Icon(Iconsax.shopping_cart,color: Colors.white,),
                SizedBox(width: 15,),
              ],
            ),
            body: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      SortFilterWidget(iconData: Icons.sort,title: 'Sort',),
                      SizedBox(width: 20,),
                      SortFilterWidget(iconData: Icons.filter_alt_sharp,title: 'Filter',),
                      Spacer(),
                      Icon(Icons.grid_view_outlined,color: Colors.red,size: 25,),
                      SizedBox(width: 10,),
                      Icon(Icons.square_outlined,color: Colors.red,size: 25),
                      SizedBox(width: 10,),
                      Icon(Icons.list_outlined,color: Colors.red,size: 25),
                    ],
                  ),
                ),
                Expanded(child:GridView.builder(
                    itemCount: provider.flashSales.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.7,
                        crossAxisCount:2), itemBuilder: (_,index){
                  final product = provider.flashSales[index];
                  return GridProductItemView(
                      image:product.image,
                      name:product.name,
                      price:'${product.price}',
                      flashSalePrice:'${product.isFlashSale}',
                      isFlashSale: product.isFlashSale ?? false,
                  );
                }))
                // Text('${provider.products.first.name}')
              ],
            ),
          );
        },
      ),
    );
  }
}

class SortFilterWidget extends StatelessWidget {
  const SortFilterWidget({
    super.key, required this.title, required this.iconData,
  });
  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Icon(iconData,color: Colors.red,size: 25,),
          Text(title,style: const TextStyle(
              color: Colors.black,fontSize: 17
          ),),
        ],
      ),
    );
  }
}
