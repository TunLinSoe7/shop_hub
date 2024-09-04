import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shop_hub/providers/product_by_category_provider.dart';

class ProductByCategoryPage extends StatelessWidget {
  const ProductByCategoryPage({super.key, required this.category});
  final String category;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>ProductByCategoryProvider(category),
      child: Consumer<ProductByCategoryProvider>(
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
                  itemCount: provider.products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.7,
                        crossAxisCount:2), itemBuilder: (_,index){
                  final product = provider.products[index];
                  return Container(
                   // height: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            color: Colors.white
                          ),
                          child: CachedNetworkImage(imageUrl: '${product.image}',height: 130,width: 150,fit: BoxFit.fill,),
                        ),
                        const SizedBox(height: 10,),
                        Text('${product.name}',style: const TextStyle(
                          fontSize: 15,
                        ),maxLines: 2,),
                        const SizedBox(height: 10,),
                        Text('${product.price} Ks',style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold
                        ),),
                        Text('${product.price} Ks',style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.bold
                        ),),
                      ],
                    ),
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
