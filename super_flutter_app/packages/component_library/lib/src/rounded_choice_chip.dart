import 'package:flutter/material.dart';

class RoundedChoiceChip extends StatelessWidget {
  final String label;
  final Widget? avatar;
  final ValueChanged<bool>? onSelected;
  final Color? labelColor;
  final Color? selectedLabelColor;
  final Color? backgroundColor;
  final Color? selectedBackgroundColor;
  final bool isSelected;

  const RoundedChoiceChip({
    required this.label,
    required this.isSelected,
    this.avatar,
    this.onSelected,
    this.labelColor,
    this.selectedLabelColor,
    this.backgroundColor,
    this.selectedBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      shape: const StadiumBorder(side: BorderSide()),
      avatar: avatar,
      label: Text(
        label,
        style: TextStyle(
          color: isSelected
              ? (selectedLabelColor ?? Colors.red)
              : (labelColor ?? Colors.black),
        ),
      ),
      onSelected: onSelected,
      selected: isSelected,
      backgroundColor: (backgroundColor ?? Colors.white),
      selectedColor: (selectedBackgroundColor ?? Colors.amber),
    );
  }
}
