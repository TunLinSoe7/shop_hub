import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationProvider extends ChangeNotifier{
  NotificationProvider(){
    notificationHandler();
  }
  void notificationHandler(){
    FirebaseMessaging.onMessage.listen((event) {
      print(event.notification!.title);
    });
  }
}