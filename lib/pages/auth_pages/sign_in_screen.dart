import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_hub/pages/auth_pages/sign_up_screen.dart';
import 'package:shop_hub/utils/helper_functions/helper_functions.dart';
import '../../providers/sign_in_proivder.dart';
import '../../utils/validators/validators.dart';
import '../../widgets/auth_widgets.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignInProvider(),
      child: Consumer<SignInProvider>(
        builder: (_, provider, __) => SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  const SizedBox(height: 20,),
                  Text(
                    'Sign In',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 20),
                  ),
                  const SizedBox(height: 20,),

                  TextFormFieldWidget(
                    validator: (value) => Validators.validateEmail(value),
                    hintText: 'Email',
                    controller: provider.emailController,
                    errorText: provider.emailError,
                  ),
                  TextFormFieldWidget(
                    validator: (value) => Validators.validatePassword(value),
                    hintText: 'Password',
                    obscureText: true,
                    controller: provider.passwordController,
                    errorText: provider.passwordError,
                  ),
                  LoginAndSignUpBtnWidget(
                    isLoading: provider.isLoading,
                    title: 'Sign in',
                    onTap: () {
                      provider.submit(context);
                    },
                  ),
                  const SocialLoginButtonWidget(
                    title: 'Sign In with Facebook',
                    borderColor: Colors.cyan,
                    titleColor: Colors.cyan,
                  ),
                  const SocialLoginButtonWidget(
                    title: 'Sign In with Google',
                    borderColor: Colors.red,
                    titleColor: Colors.red,
                  ),
                  const SizedBox(height: 10,),
                  HaveAnAccWidget(
                    onTap: () {
                      HelperFunctions.navigateToScreen(const SignUpScreen(), context);
                    },
                    title: 'You don\'t have an account?',
                    subTitle: ' SignUp',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
