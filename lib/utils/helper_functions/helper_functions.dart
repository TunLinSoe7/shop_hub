import 'package:flutter/material.dart';

class HelperFunctions{
  static void navigateToScreen(Widget screen,BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>screen));
  }
}