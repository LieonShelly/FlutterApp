import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExpandedElevatedButton extends StatelessWidget {
  static const double _elevatedButtonHeight = 48;

  const ExpandedElevatedButton({
    required this.label,
    this.onTap,
    this.icon,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onTap;
  final String label;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final icon = this.icon;
    return SizedBox(
      height: _elevatedButtonHeight,
      width: double.infinity,
      child: icon != null
          ? ElevatedButton.icon(
              onPressed: onTap,
              label: Text(label),
              icon: icon,
            )
          : ElevatedButton(onPressed: onTap, child: Text(label)),
    );
  }
}
