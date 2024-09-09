import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_hub/providers/cart_provider.dart';
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<CartProvider>(
        builder: (_, provider, __) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Colors.black,
              title: const Text('Cart',style: TextStyle(color: Colors.white),),
              centerTitle: true,
            ),
            backgroundColor: Colors.white.withOpacity(0.96),
            body: ListView(
              children: [
                Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: provider.cartItems?.length,
                      itemBuilder: (_, index) {
                        final cart = provider.cartItems?[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Image
                              CachedNetworkImage(
                                imageUrl: '${cart?.imageUrl}',
                                width: 100,
                                height: 100,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${cart?.name}"),
                                    const SizedBox(height: 15),
                                    const Text("Color: Black", maxLines: 1),
                                    const Text("Storage: 6/128GB", maxLines: 1),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      'Ks ${cart?.price}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 15),
                                      padding: const EdgeInsets.all(8),
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.grey.withOpacity(0.1),
                                      ),
                                      child:  Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap:(){
                                              provider.decreaseProduct(cart!);
                                            },
                                            child: const Icon(
                                              Icons.remove,
                                              color: Colors.red,
                                            ),
                                          ),
                                          Text(
                                            '${cart?.productQuantity}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              provider.increaseProduct(cart!);
                                            },
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Coupon'),
                          Row(
                            children: [
                              const Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Enter your coupon code',
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 100,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red,
                                ),
                                child: const Text(
                                  "Apply",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              'Shipping Address',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_rounded,
                                      color: Colors.red,
                                    ),
                                    Text('Shipping Address')
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text('ကြည်မြင်တိုင်,နတ်စင်လမ်း'),
                                SizedBox(height: 10),
                                Text('09951812537'),
                                SizedBox(height: 10),
                                Text('ရန်ကုန်,မြန်မာ'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20,),
                          const TaxAndTotalWidget(title: 'Tax',price: '0 Ks',),
                          const SizedBox(height: 20,),
                          const TaxAndTotalWidget(title: 'Total',price: '50000 Ks',),
                          const SizedBox(height: 20,),
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.red,
                            ),
                            child: const Text('Proceed to checkout',style: TextStyle(
                              color: Colors.white
                            ),),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TaxAndTotalWidget extends StatelessWidget {
  const TaxAndTotalWidget({
    super.key, this.title, this.price,
  });
  final String? title;
  final String? price;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title ?? ''),
        const Spacer(),
        Text(price ?? ''),
      ],
    );
  }
}


