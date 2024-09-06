import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GridProductItemView extends StatelessWidget {
  const GridProductItemView({
    super.key, this.image, this.name, this.price, this.flashSalePrice, required this.isFlashSale,
  });

  final String? image;
  final String? name;
  final String? price;
  final String? flashSalePrice;
  final bool isFlashSale;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
                child: CachedNetworkImage(imageUrl: image ?? '',height: 130,width: 150,fit: BoxFit.fill,),
              ),
              const SizedBox(height: 10,),
              Text(name ?? '',style: const TextStyle(
                fontSize: 15,
              ),maxLines: 2,),
              const SizedBox(height: 10,),
              Text('$price Ks',style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold
              ),),
              Text('$flashSalePrice Ks',style: const TextStyle(
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                  fontWeight: FontWeight.bold
              ),),
            ],
          ),
        ),
        isFlashSale?Positioned(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red,
                ),
                child: const Text('Promo',style: TextStyle(
                    color: Colors.white,
                    fontSize: 12
                ),))):const SizedBox(),
      ],
    );
  }
}
