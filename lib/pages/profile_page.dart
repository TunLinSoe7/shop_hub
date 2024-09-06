import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shop_hub/providers/profile_page_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>ProfilePageProvider(),
      child: Consumer<ProfilePageProvider>(
        builder: (_,provider,__)=>SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  const SizedBox(height: 50,),
                  ListTile(
                    leading: Image.asset('assets/images/profile_image.png'),
                    title: const Text('UR Cristiano'),
                    subtitle: const Text('cristiano@gmail.com'),
                    trailing: const Icon(Iconsax.setting),
                  ),
                  const SizedBox(height: 20,),
                  Card(
                    color: Colors.white,
                    elevation: 0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ProfileListTileWidget(onTap:(){

                          },icon: Iconsax.location,title: 'Address',),
                          const Divider(color: Colors.grey,thickness: 0.2,),
                          const ProfileListTileWidget(icon: Iconsax.wallet,title: 'Payment method',),
                          const Divider(color: Colors.grey,thickness: 0.2,),
                          const ProfileListTileWidget(icon: Iconsax.heart4,title: 'My Whistlist',),
                          const Divider(color: Colors.grey,thickness: 0.2,),
                          const ProfileListTileWidget(icon: Iconsax.star,title: 'Rate this app',),
                          const Divider(color: Colors.grey,thickness: 0.2,),
                          ProfileListTileWidget(icon: Iconsax.logout,title: 'Logout',onTap: (){
                            provider.logOut();
                          },)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileListTileWidget extends StatelessWidget {
  const ProfileListTileWidget({
    super.key, required this.icon, required this.title, this.onTap,
  });
  final IconData icon;
  final String title;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),title: Text(title),trailing: const Icon(Iconsax.arrow_right_3),);
  }
}
