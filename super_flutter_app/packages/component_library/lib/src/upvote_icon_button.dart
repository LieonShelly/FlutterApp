import 'package:component_library/src/count_indicator_icon_button.dart';
import 'package:flutter/material.dart';

class UpvoteIconButton extends StatelessWidget {
  final int count;
  final bool isUpVoted;
  final VoidCallback? onTap;

  const UpvoteIconButton({
    required this.count,
    required this.isUpVoted,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Countindicatoriconbutton(
      onTap: onTap,
      tooltip: 'Upvote',
      iconData: Icons.arrow_upward_sharp,
      iconColor: isUpVoted ? Colors.red : Colors.black,
      count: count,
    );
  }
}
