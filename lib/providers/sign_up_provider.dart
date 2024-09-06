import 'package:flutter/material.dart';
import 'package:shop_hub/navigation_menu.dart';
import 'package:shop_hub/network/auth_data_agent/auth_data_agent.dart';
import 'package:shop_hub/network/auth_data_agent/auth_data_agent_impl.dart';
import '../utils/helper_functions/helper_functions.dart';
import '../utils/validators/validators.dart';

class SignUpProvider extends ChangeNotifier {
  bool _isDisposed = false;
  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthDataAgent _authModel = AuthDataAgentImpl();

  String? _emailError;
  String? _passwordError;
  String? _nameError;
  String? _phoneError;
  String? _confirmPasswordError;

  // Getters
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get nameController => _userNameController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get confirmPasswordController => _confirmPasswordController;
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;
  String? get confirmPasswordError => _confirmPasswordError;
  String? get phoneError => _phoneError;
  String? get nameError => _nameError;
  bool get isLoading => _isLoading;

  SignUpProvider() {
    // Set up listeners for text changes
    _emailController.addListener(() {
      _emailError = Validators.validateEmail(_emailController.text);
      notifyListeners();
    });

    _passwordController.addListener(() {
      _passwordError = Validators.validatePassword(_passwordController.text);
      notifyListeners();
    });
    _confirmPasswordController.addListener(() {
      _confirmPasswordError = Validators.validateConfirmPassword(_confirmPasswordController.text, _passwordController.text);
      notifyListeners();
    });
    _userNameController.addListener(() {
      _nameError = Validators.validateName(_userNameController.text);
      notifyListeners();
    });
    _phoneController.addListener(() {
      _phoneError = Validators.validateMyanmarPhoneNumber(_phoneController.text);
      notifyListeners();
    });

  }
  Future<void> signUp(BuildContext context)async{
    try{
      _isLoading = true;
      notifyListeners();
      if(_passwordController.text == _confirmPasswordController.text){
        await _authModel.registerUser(email: _emailController.text, password: _passwordController.text,name: _userNameController.text,phoneNumber: _phoneController.text);
        HelperFunctions.navigateToScreen(const NavigationMenu(), context);
      }
      _isLoading = false;
      notifyListeners();
    }catch (e){
      _isLoading = false;
      //showSnackBar(context);
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
    _userNameController.dispose();
    _phoneController.dispose();
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
    _nameError = Validators.validateName(_userNameController.text);
    _confirmPasswordError = Validators.validateConfirmPassword(_confirmPasswordController.text, _passwordController.text);
    _phoneError = Validators.validateMyanmarPhoneNumber(_phoneController.text);
    notifyListeners();

    if (_emailError == null && _passwordError == null && _nameError == null && _phoneError == null && _confirmPasswordError == null) {
      signUp(context);
    }
  }
}
