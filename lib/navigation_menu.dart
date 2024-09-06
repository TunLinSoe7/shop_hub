import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shop_hub/providers/navigation_provider.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>NavigationProvider(),
      child: Consumer<NavigationProvider>(
        builder: (_,provider,__)=>Scaffold(
          backgroundColor: Colors.black,
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: provider.currentIndex,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              unselectedLabelStyle: const TextStyle(
                  color: Colors.grey
              ),
              showUnselectedLabels: true,
              onTap: (value){
                provider.setIndex = value;
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Iconsax.home),label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Iconsax.notification),label: 'Notifications'),
                BottomNavigationBarItem(icon: Icon(Iconsax.shopping_cart),label: 'Cart'),
                BottomNavigationBarItem(icon: Icon(Iconsax.user),label: 'Profile'),
              ]),
          body: IndexedStack(
            index: provider.currentIndex,
            children: provider.screens,
          ),
        ),
      ),
    );
  }
}
