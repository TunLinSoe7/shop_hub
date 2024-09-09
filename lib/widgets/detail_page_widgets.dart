import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_hub/data/vos/product_vo.dart';
import 'package:shop_hub/providers/cart_provider.dart';
import 'package:shop_hub/providers/product_detail_provider.dart';

Container buildAddToCart(BuildContext context,ProductVO productVO,int quantity,ProductDetailProvider detailProvider) {
  final provider = context.read<CartProvider>();
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
    color: Colors.white,
    alignment: Alignment.center,
    height: 60,
    child: Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              IconButton(onPressed: (){
               detailProvider.decrease(quantity);
              }, icon:const Icon(Icons.remove,color: Colors.red,)),
              /// show quantity
              Text('$quantity'),
              IconButton(onPressed: (){
               detailProvider.increase(quantity);
              }, icon:const Icon(Icons.add,color: Colors.red,)),
            ],
          ),
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: GestureDetector(
            onTap: (){
              provider.addToCart(productVO,quantity);
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(13),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red
              ),
              child: const Text('Add To Cart',style: TextStyle(
                  color: Colors.white
              ),),
            ),
          ),
        ),
      ],
    ),
  );
}


class DetailImageWidget extends StatelessWidget {
  const DetailImageWidget({
    super.key, required this.imageUrl,
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: CachedNetworkImage(imageUrl: imageUrl));
  }
}

class StorageDescriptionWidget extends StatelessWidget {
  const StorageDescriptionWidget({
    super.key, required this.description,
  });
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Storage',style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Colors.black
        ),),
        const SizedBox(height: 15,),
        SizedBox(height:40,child: ListView.separated(
            separatorBuilder: (_,index)=>const SizedBox(width: 15,),
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (_,index){
              return Container(
                alignment: Alignment.center,
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey)
                ),
                child: const Text('12/128GB'),
              );
            }),),
        const SizedBox(height: 15,),
        Text(description,style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Colors.grey
        ),textAlign: TextAlign.justify,),
      ],
    );
  }
}

class TitlePriceWidget extends StatelessWidget {
  const TitlePriceWidget({
    super.key, required this.title, required this.price, required this.flashSalePrice,
  });
  final String title;
  final String price;
  final String flashSalePrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: 200,
                child: Text(title,style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.black
                ),maxLines: 2,)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$price MMK',style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    decoration: TextDecoration.lineThrough
                ),),
                const SizedBox(width: 10,),
                Text('$flashSalePrice MMK',style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.black
                ),),
              ],
            ),
          ],
        ),
        const Spacer(),
        Text('In Stock',style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Colors.green
        ),),
      ],
    );
  }
}
