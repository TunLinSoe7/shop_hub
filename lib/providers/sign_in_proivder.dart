import 'package:flutter/material.dart';

import 'package:shop_hub/network/auth_data_agent/auth_data_agent.dart';
import 'package:shop_hub/network/auth_data_agent/auth_data_agent_impl.dart';
import '../utils/validators/validators.dart';

class SignInProvider extends ChangeNotifier {
  bool _isDisposed = false;
  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthDataAgent _authDataAgent = AuthDataAgentImpl();

  String? _emailError;
  String? _passwordError;

  // Getters
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;
  bool get isLoading => _isLoading;

  SignInProvider() {
    // Set up listeners for text changes
    _emailController.addListener(() {
      _emailError = Validators.validateEmail(_emailController.text);
      notifyListeners();
    });

    _passwordController.addListener(() {
      _passwordError = Validators.validatePassword(_passwordController.text);
      notifyListeners();
    });
  }

  Future<void> login(BuildContext context)async{
    try{
      _isLoading = true;
      notifyListeners();
      await _authDataAgent.signInUser(email: _emailController.text, password: _passwordController.text);
      _isLoading = false;
      notifyListeners();
    }catch (e){
      _isLoading = false;
     // showSnackBar(context);
      notifyListeners();
      throw Exception('error${e.toString()}');
    }
    notifyListeners();
  }
  @override
  void dispose() {
    _isDisposed = true;
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_isDisposed) {
      super.notifyListeners();
    }
  }

  void submit(BuildContext context) {
    _emailError = Validators.validateEmail(_emailController.text);
    _passwordError = Validators.validatePassword(_passwordController.text);
    notifyListeners();
    if (_emailError == null && _passwordError == null) {
      login(context);
    }
  }
}
