import 'package:flutter/material.dart';
import 'package:shop_hub/network/auth_data_agent/auth_data_agent.dart';
import 'package:shop_hub/network/auth_data_agent/auth_data_agent_impl.dart';

class ProfilePageProvider extends ChangeNotifier{
  bool _isDispose  = false;
  final AuthDataAgent _authModel = AuthDataAgentImpl();

  Future<void> logOut()async{
    await _authModel.logout();
    notifyListeners();
  }
  @override
  void dispose() {
    _isDispose = true;
    super.dispose();
  }
  @override
  void notifyListeners() {
    if(!_isDispose){
      super.notifyListeners();
    }
  }

}