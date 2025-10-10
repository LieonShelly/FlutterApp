import 'package:component_library/src/count_Indicator_icon_button.dart';
import 'package:flutter/material.dart';

class DownvoteIconButton extends StatelessWidget {
  final int count;
  final bool isDownvoted;
  final VoidCallback? onTap;

  const DownvoteIconButton({
    required this.count,
    required this.isDownvoted,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Countindicatoriconbutton(
      onTap: onTap,
      tooltip: 'Downvote',
      iconData: Icons.arrow_upward_sharp,
      iconColor: isDownvoted ? Colors.red : Colors.black,
      count: count,
    );
  }
}
