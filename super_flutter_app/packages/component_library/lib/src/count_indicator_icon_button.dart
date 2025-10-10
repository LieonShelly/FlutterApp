import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class Countindicatoriconbutton extends StatelessWidget {
  final int count;
  final IconData iconData;
  final Color? iconColor;
  final String? tooltip;
  final VoidCallback? onTap;

  const Countindicatoriconbutton({
    required this.count,
    required this.iconData,
    this.iconColor,
    this.tooltip,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      tooltip: tooltip,
      padding: const EdgeInsets.all(0),
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, color: iconColor),
          Text(
            count.toString(),
            style: const TextStyle(fontSize: FontSize.small),
          ),
        ],
      ),
    );
  }
}
