import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:shop_hub/data/vos/product_vo.dart';
import 'package:shop_hub/pages/fashion_all_page.dart';
import 'package:shop_hub/pages/prodcut_by_category_page.dart';
import 'package:shop_hub/pages/product_detail_screen.dart';
import 'package:shop_hub/pages/search_page.dart';
import 'package:shop_hub/pages/see_all_flash_sale_page.dart';
import 'package:shop_hub/providers/home_screen_provider.dart';
import 'package:shop_hub/utils/helper_functions/helper_functions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final List<String> imgList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCNtSmrereXXrTYm1uP5LFtb2aVwg8M2I-UA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSos9jzV60wcIIg-Qgn-TeVCP5hJ5CjjabBtw&s',
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>HomeScreenProvider(),
      child: Consumer<HomeScreenProvider>(
        builder: (_,provider,__)=>Scaffold(
          floatingActionButton: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle
            ),
            child: const Icon(Icons.chat,color: Colors.white,),
          ),
          backgroundColor: Colors.white.withOpacity(0.96),
          body: CustomScrollView(
            controller: provider.scrollController,
            slivers: <Widget>[
              buildSliverAppBar(provider),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          DotIndicatorWidget(imgList: imgList,currentIndex: provider.currentIndexPage,),
                          /// Coupon
                          const CouponWidget(),
                          const SizedBox(height: 15,),
                          /// category
                          const CategoryWidget(),
                          /// flash sale title start time , end time
                          const FlashSaleTitleAndStartEndTimeWidget(),

                          /// fashions collection
                          Column(
                            children: [
                              ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                                title: const Text('Fashions Collection',style: TextStyle(
                                    color: Colors.black,fontSize: 17,
                                    fontWeight: FontWeight.bold
                                ),),trailing: GestureDetector(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const SeeAllFashionPage()));
                                },
                                child: const Text('See all',style: TextStyle(
                                    fontSize: 15
                                ),),
                              ),),
                              const FashionProductWidget(),
                            ],
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar buildSliverAppBar(HomeScreenProvider provider) {
    return SliverAppBar(
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              title: GestureDetector(
                onTap: (){
                  HelperFunctions.navigateToScreen(const SearchPage(), context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.centerLeft,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: provider.searchBoxColor,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search,color: Colors.grey.withOpacity(0.5),),
                      Text('Search Products',style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.withOpacity(0.5)
                      ),)
                    ],
                  ),
                ),
              ),
              actions: [
                Icon(
                  Icons.mail,
                  color: provider.iconColor,
                ),
                const SizedBox(width: 10),
                Icon(Icons.notifications, color: provider.iconColor),
                const SizedBox(width: 15),
              ],
              expandedHeight: 250.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: CarouselSlider(
                  options: CarouselOptions(
                    onPageChanged: (index,reason){
                      provider.currentIndex = index;
                    },
                    autoPlay: true,
                    viewportFraction: 1.0,
                    aspectRatio: 2.0,
                    height: double.infinity,
                  ),
                  items: imgList
                      .map((item) =>
                      Image.network(item, fit: BoxFit.cover, width: double.infinity))
                      .toList(),
                ),
              ),
            );
  }
}

class FlashSaleTitleAndStartEndTimeWidget extends StatelessWidget {
  const FlashSaleTitleAndStartEndTimeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          children: [
            const Text('Flash Sale Today⚡',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
            const Spacer(),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const SeeAllFlashSalePage()));
              },
                child: const Text('See all'))
          ],
        ),
        const SizedBox(height: 15,),
        const FlashSaleProductWidget(),
      ],
    ));
  }
}

class FashionProductWidget extends StatelessWidget {
  const FashionProductWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return Selector<HomeScreenProvider,List<ProductVO>?>(builder: (_,fashions,__){
      return SizedBox(
          height: 230,
        child: ListView.separated(
            separatorBuilder: (_,index)=>const SizedBox(width: 15,),
            scrollDirection: Axis.horizontal,
            itemCount: fashions?.length ?? 0,itemBuilder: (_,index){
              final fashionProducts = fashions?[index];
          return ProductItemView(
            onTap: (){
              HelperFunctions.navigateToScreen(ProductDetailScreen(productId: fashionProducts?.productId ?? '', category: fashionProducts?.category ?? ''), context);
            },
            image: fashionProducts?.image ?? '',
            name: fashionProducts?.name ?? '',
            price: '${fashionProducts?.price}',
            flashSalePrice: '${fashionProducts?.price}', isFlashSale: fashionProducts?.isFlashSale ?? false,
          );
        })
      );
    }, selector: (_,provider)=>provider.fashions);
  }
}

class ProductItemView extends StatelessWidget {
  const ProductItemView({
    super.key, this.image, this.name, this.price, this.flashSalePrice, required this.isFlashSale, this.onTap,
  });
  final String? image;
  final String? name;
  final String? price;
  final String? flashSalePrice;
  final bool isFlashSale;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap:onTap,
                          child: CachedNetworkImage(imageUrl: image??'',fit: BoxFit.contain,width: 100,height: 100,)),
                    ],
                  ),

              const SizedBox(height: 10,),
              SizedBox(
                height: 35,
                child: Text(name ?? '',style: const TextStyle(
                    color: Colors.black
                ),maxLines: 2,),
              ),
              const SizedBox(height: 10,),
              Text('$price ks',style: const TextStyle(
                  color: Colors.red,
                fontWeight: FontWeight.bold
              ),maxLines: 1,),
              isFlashSale?Text('$flashSalePrice Ks',style: const TextStyle(
                  color: Colors.grey,
                decoration: TextDecoration.lineThrough,
                fontWeight: FontWeight.bold
              ),maxLines: 1,):const SizedBox(),
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
            child: const Text('OnSale',style: TextStyle(
              color: Colors.white,
              fontSize: 12
            ),))):const SizedBox(),
      ],
    );
  }
}
class FlashSaleProductWidget extends StatelessWidget {
  const FlashSaleProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<HomeScreenProvider,List<ProductVO>?>(builder: (_,flashSales,__){
      return SizedBox(
          height: 230,
        child: ListView.separated(
            separatorBuilder: (_,index)=>const SizedBox(width: 15,),
            scrollDirection: Axis.horizontal,
            itemCount: flashSales?.length ?? 0,itemBuilder: (_,index){
          final product = flashSales?[index];
          return ProductItemView(
            onTap: (){
              HelperFunctions.navigateToScreen(ProductDetailScreen(productId: product?.productId ?? '',category: product?.category ?? '',), context);
            },
            isFlashSale: product?.isFlashSale ?? false,
            image: product?.image ?? '',
            name: product?.name ?? '',
            price: '${product?.price}',
            flashSalePrice: '${product?.price}',
          );
        })
      );
    }, selector: (_,provider)=>provider.flashSales);
  }
}


class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(builder: (_,categoryProvider,__){
      return SizedBox(height: 100,child:ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryProvider.categories.length,
          itemBuilder: (_,index){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ProductByCategoryPage(category: '${categoryProvider.categories[index].name}')));
                    },
                    child: CachedNetworkImage(imageUrl: '${categoryProvider.categories[index].image}',fit: BoxFit.contain,height: 50,width: 80,)),
                Expanded(child: SizedBox(
                    child: Text('${categoryProvider.categories[index].name}')))
              ],
            );
          }));
    });
  }
}

class CouponWidget extends StatelessWidget {
  const CouponWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.cyan,
        borderRadius: BorderRadius.circular(5)
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: const Row(
        children: [
          Text('There are 10 coupons waiting',style: TextStyle(
            color: Colors.white,
            fontSize: 16
          ),),
          Spacer(),
          Icon(Icons.sell,color: Colors.white,)
        ],
      ),
    );
  }
}

class DotIndicatorWidget extends StatelessWidget {
  const DotIndicatorWidget({
    super.key,
    required this.imgList,
    required this.currentIndex,
  });

  final List<String> imgList;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(dotsCount: imgList.length,
      position: currentIndex ,
      decorator: const DotsDecorator(
        color: Colors.grey,
        activeColor: Colors.cyan
      ),
    );
  }
}

