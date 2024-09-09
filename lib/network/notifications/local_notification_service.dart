
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalNotificationService{
 Future<void> requestPermission()async{
   PermissionStatus permissionStatus = await Permission.notification.request();
   if(permissionStatus != PermissionStatus.granted){
     throw Exception('Permission not granted.');
   }
 }
 Future<void> uploadFCMToken()async {
   try{
     await FirebaseMessaging.instance.getToken().then((token) => token);
   }catch(e){
     throw Exception(e.toString());
   }
 }
}