import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../navigation_menu.dart';
import '../../pages/auth_pages/sign_in_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder:(context,snapshot){
      if(snapshot.hasData){
        return const NavigationMenu();
      }else{
        return const SignInScreen();
      }
    });
  }
}
