import 'package:flutter/material.dart';

class SortFilterWidget extends StatelessWidget {
  const SortFilterWidget({
    super.key,
    required this.title,
    required this.iconData,
    this.onTap,
  });

  final String title;
  final IconData iconData;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.black, fontSize: 17),
            ),
            Icon(
              iconData,
              color: Colors.grey,
              size: 25,
            ),
          ],
        ),
      ),
    );
  }
}
