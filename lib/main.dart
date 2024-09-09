import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_hub/network/auth_data_agent/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shop_hub/providers/cart_provider.dart';
import 'package:shop_hub/providers/notification_provider.dart';
import 'package:toastification/toastification.dart';
import 'firebase_options.dart';
import 'network/notifications/local_notification_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService().requestPermission();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>CartProvider()),
      ChangeNotifierProvider(create: (_)=>NotificationProvider()),
    ],child: const MyApp(),),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:const AuthGate()
      ),
    );
  }
}