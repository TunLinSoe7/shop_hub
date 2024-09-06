import 'package:flutter/material.dart';
import 'package:shop_hub/pages/cart_screen.dart';
import 'package:shop_hub/pages/home_page.dart';
import 'package:shop_hub/pages/notification_screen.dart';
import 'package:shop_hub/pages/profile_page.dart';


class NavigationProvider extends ChangeNotifier{
  bool _isDispose  = false;
  int _currentIndex = 0;
  set setIndex(int newIndex){
    _currentIndex = newIndex;
    notifyListeners();
  }
  int get currentIndex=>_currentIndex;

  List<Widget> screens =const [
    HomePage(),
    NotificationScreen(),
    CartScreen(),
    ProfilePage()
  ];


  @override
  void dispose() {
    _isDispose = true;
    super.dispose();
  }
  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    if(!_isDispose){
      super.notifyListeners();
    }
  }
}