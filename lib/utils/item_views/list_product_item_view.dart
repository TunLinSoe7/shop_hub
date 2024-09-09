import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListProductItemView  extends StatelessWidget{

  const ListProductItemView({super.key, required this.title, required this.image, required this.promoPrice, required this.isFlashSale, required this.originalPrice});
  final String title;
  final String image;
  final String promoPrice;
  final String originalPrice;
  final bool isFlashSale;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15,left: 15,right: 15),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white
                          ),
                          child: CachedNetworkImage(imageUrl: image,width: 100,height: 100,fit: BoxFit.fill,)),
                      const SizedBox(width: 15,),
                      Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          isFlashSale?Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.red
                            ),
                            child: const Text('OnSale',style: TextStyle(
                                fontSize: 12,
                                color: Colors.white
                            ),),):const SizedBox(),
                          Text(title,style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),),
                          const SizedBox(height: 10,),
                          Text('$promoPrice Ks',style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),),
                          const  SizedBox(height: 10,),
                          Text('$originalPrice Ks',style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 15,
                              color: Colors.grey
                          ),),
                        ],
                      ),
                    ],
                  ),
                ),
                const Positioned(
                    right: 5,
                    child: Icon(Icons.shopping_cart)),
              ],
            ),
            Divider(color: Colors.grey.shade300,),
          ],
        ),
      ),
    );
  }
}
