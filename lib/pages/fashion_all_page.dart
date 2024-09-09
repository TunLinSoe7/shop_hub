import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shop_hub/pages/cart_screen.dart';
import 'package:shop_hub/pages/search_page.dart';
import 'package:shop_hub/providers/fashion_all_provider.dart';
import 'package:shop_hub/utils/helper_functions/helper_functions.dart';
import '../utils/item_views/grid_product_item_views.dart';
import '../widgets/fashion_see_all_page_widgets.dart';
import '../widgets/htlOrlthtextWidget.dart';
import '../widgets/list_and_grid_widget.dart';
import '../widgets/sort_by_price_widges.dart';
import '../widgets/sort_filter_widgets.dart';

class SeeAllFashionPage extends StatelessWidget {
  const SeeAllFashionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SellAllFashionProvider(),
      child: Consumer<SellAllFashionProvider>(
        builder: (_, provider, __) {
          return Scaffold(
            backgroundColor: Colors.white.withOpacity(0.96),
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Colors.black,
              actions: [
                GestureDetector(
                    onTap: () {HelperFunctions.navigateToScreen(const SearchPage(), context);},
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                    onTap: () {
                      HelperFunctions.navigateToScreen(const CartScreen(), context);
                    },
                    child: const Icon(
                      Iconsax.shopping_cart,
                      color: Colors.white,
                    )),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      /// sorting price is low to high or high to low
                      provider.lowOrHighText.isNotEmpty?HTLORLTHText(title: provider.lowOrHighText):const SizedBox(),
                      const Spacer(),
                      /// sort and filter products
                      SortFilterWidget(
                        onTap: () {
                          buildShowModalBottomSheet(
                              (){
                                provider.sortPriceLowToHigh();
                                provider.lowOrHighText = 'Low To High';
                                Navigator.of(context).pop();
                              },
                              (){
                                provider.sortPriceHighToLow();
                                provider.lowOrHighText = 'High To Low';
                                Navigator.of(context).pop();
                              },
                              context,
                              provider.currentIndex,
                                  (index) {
                                provider.setIndex(index, context);
                              }
                          );
                        },
                        iconData: Icons.keyboard_arrow_down,
                        title: 'Filter',
                      ),
                    ],
                  ),
                ),
                /// sorting product is list or grid
                ShowProductIsListOrGridWidget(provider: provider,),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet(
      GestureTapCallback? onTapLTH,
      GestureTapCallback? onTapHTL,
      BuildContext context, int selectedIndex, Function(int) onTap) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                color: Colors.white
            ),
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Spacer(),
                    IconButton(onPressed: (){}, icon: const Text('Apply',style: TextStyle(
                        color: Colors.cyan,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),)),
                  ],
                ),
                const Text('Layouts',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),),
                const SizedBox(height: 15,),
                SizedBox(height: 50,child: ListView.separated(
                    separatorBuilder: (_,index)=> const SizedBox(width: 15,),
                    scrollDirection: Axis.horizontal,
                    itemCount: icons.length,
                    itemBuilder: (_,index){
                      return ListAndGridWidget(
                        onTap: () {
                          onTap(index);
                        },
                        iconData: icons[index],
                        isSelected: selectedIndex == index,
                      );
                    }),),
                const SizedBox(height: 20,),
                const Text('Sort',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),),
                Row(
                  children: [
                    Expanded(child: SortByPriceWidget(onTapSort: onTapLTH,title: 'Low To High',)),
                    const SizedBox(width: 20,),
                    Expanded(child: SortByPriceWidget(onTapSort: onTapHTL,title: 'High To Low',)),
                  ],
                ),
              ],
            ),
          );
        });
  }
}





List icons = [Icons.grid_view_outlined, Icons.list_alt_outlined];



