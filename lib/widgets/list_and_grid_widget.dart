import 'package:flutter/material.dart';

class ListAndGridWidget extends StatelessWidget {
  const ListAndGridWidget({
    super.key, required this.iconData, required this.isSelected, this.onTap,
  });
  final IconData iconData;
  final bool isSelected;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 70,
        decoration: BoxDecoration(
          color: isSelected ? Colors.cyan.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color: isSelected ? Colors.cyan : Colors.grey.shade600
          ),
        ),
        child: Icon(iconData, color: isSelected ? Colors.cyan : Colors.grey.shade600,),
      ),
    );
  }
}
