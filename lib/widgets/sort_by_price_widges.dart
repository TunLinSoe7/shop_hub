import 'package:flutter/material.dart';

class SortByPriceWidget extends StatelessWidget {
  const SortByPriceWidget({
    super.key, this.onTapSort, this.title,
  });

  final GestureTapCallback? onTapSort;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapSort,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.shade300
        ),
        child: Text('Price : $title',style: const TextStyle(
            fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}
