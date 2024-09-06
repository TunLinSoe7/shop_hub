import 'package:flutter/material.dart';

class HaveAnAccWidget extends StatelessWidget {
  const HaveAnAccWidget({
    super.key, required this.title, required this.subTitle, required this.onTap,
  });
  final String title;
  final String subTitle;
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title,style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Colors.grey
        ),),
        InkWell(
          onTap: onTap,
            child: Text(subTitle,style: Theme.of(context).textTheme.titleMedium)),
      ],
    );
  }
}

class SocialLoginButtonWidget extends StatelessWidget {
  const SocialLoginButtonWidget({
    super.key, required this.title, required this.borderColor, required this.titleColor, this.isLoading = false,
  });
  final String title;
  final Color borderColor;
  final Color titleColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          border: Border.all(
              color: borderColor,
              width: 2
          )
      ),
      child: isLoading?const Center(child: CircularProgressIndicator()):Text(title,style: Theme.of(context).textTheme.titleMedium!.copyWith(
          color: titleColor
      ),),
    );
  }
}


class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key, required this.hintText, this.suffixIcon = Icons.remove_red_eye,this.obscureText = false, required this.controller, this.errorText, this.validator, this.onChanged,
  });
  final String hintText;
  final IconData suffixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final String? errorText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        controller: controller,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.w200
        ),
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: obscureText?Icon(suffixIcon):null,
          errorText: errorText
        ),
        obscureText:obscureText ,
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}


class LoginAndSignUpBtnWidget extends StatelessWidget {
  const LoginAndSignUpBtnWidget({
    super.key, required this.title, this.onTap,
    this.isLoading = false,
  });
  final String title;
  final GestureTapCallback? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading?null:onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.cyan
        ),
        child: isLoading?const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2.0,
          ),
        ):Text(title,style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Colors.white
        ),),
      ),
    );
  }
}