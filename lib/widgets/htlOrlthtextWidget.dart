import 'package:flutter/material.dart';

class HTLORLTHText extends StatelessWidget {
  const HTLORLTHText({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5),
        decoration:BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.black
        ),
        child: Text(title ?? '',style: const TextStyle(
            color: Colors.white
        ),));
  }
}
