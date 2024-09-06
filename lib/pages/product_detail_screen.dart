import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shop_hub/pages/home_page.dart';
import 'package:shop_hub/providers/product_detail_provider.dart';
import '../widgets/detail_page_widgets.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.productId, required this.category});

  final String productId;
  final String category;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (_) => ProductDetailProvider(productId,category),
        child: Consumer<ProductDetailProvider>(
          builder: (_, provider, __) {
            return Scaffold(
              backgroundColor: Colors.white.withOpacity(0.96),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                    child: const Icon(Icons.arrow_back_ios,color: Colors.black,)),
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                actions: const [
                  Icon(Iconsax.notification),
                  SizedBox(width: 15,),
                  Icon(Iconsax.shopping_bag),
                  SizedBox(width: 15,),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// image
                      DetailImageWidget(
                        imageUrl: '${provider.productVO?.image}',),
                      const SizedBox(height: 15,),
                  
                      /// title and price
                      TitlePriceWidget(title: '${provider.productVO?.name}',
                          price: '${provider.productVO?.price}',
                          flashSalePrice: '${provider.productVO?.price}'),
                      const Divider(color: Colors.black, thickness: 0.3,),
                  
                      /// storage and description
                      StorageDescriptionWidget(
                        description: '${provider.productVO?.description}',),
                      const Divider(color: Colors.black, thickness: 0.3,),
                      /// specification
                      const SpecificationsWidget(),
                      Text('Related Products',style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade700
                      ),),

                      SizedBox(
                        height: 230,
                        child: ListView.separated(
                            separatorBuilder: (_,index)=>const SizedBox(width: 10,),
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.relatedProducts?.length ?? 0,itemBuilder: (_,index){
                              final related = provider.relatedProducts?[index];
                          return ProductItemView(
                              name:'${related?.name}',
                              price:'${related?.price}',
                              flashSalePrice:'${related?.price}',
                              image: '${related?.image}',
                              isFlashSale: true);
                        }),
                      )
                    ],
                  ),
                ),
              ),

              /// increase decrease and add to cart button
              bottomNavigationBar: buildAddToCart(),
            );
          },
        ),
      ),
    );
  }
}

class SpecificationsWidget extends StatelessWidget {
  const SpecificationsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Specifications',style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 18
        ),),
        const SizedBox(height: 20,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Model:',style: TextStyle(color: Colors.grey.shade600),),
            const SizedBox(width: 55,),
            Expanded(child: Text('MatePad 11.5s PaperMatte Edition',style:TextStyle(color: Colors.grey.shade600))),
          ],
        ),
        const Divider(color: Colors.black, thickness: 0.3,),
        const SizedBox(height: 20,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Display:',style: TextStyle(color: Colors.grey.shade600),),
            const SizedBox(width: 55,),
            Expanded(child: Text('The iPhone 14 Pro features a 6.1-inch Super Retina XDR display with ProMotion, offering a 120Hz refresh rate for smoother scrolling and animations.',style:TextStyle(color: Colors.grey.shade600))),
          ],
        ),
        const Divider(color: Colors.black, thickness: 0.3,),
        const SizedBox(height: 20,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Resolutions:',style: TextStyle(color: Colors.grey.shade600),),
            const SizedBox(width: 55,),
            Expanded(child: Text('2200 * 1440Px,229 PPI',style:TextStyle(color: Colors.grey.shade600))),
          ],
        ),
        const Divider(color: Colors.black, thickness: 0.3,),
        const SizedBox(height: 10,),
      ],
    );
  }
}