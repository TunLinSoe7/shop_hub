import 'package:firebase_auth/firebase_auth.dart';
import '../../data/vos/user_vo.dart';

abstract class AuthDataAgent{
  Future<UserCredential> signInUser({required String email,required String password});
  Future<UserCredential> registerUser({
    required String email,required String password,
    required String name,required String phoneNumber,
  });
  Future<void> logout();
  Future<void> saveUserData(UserVO user);
}