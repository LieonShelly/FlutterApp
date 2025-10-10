import 'package:flutter/material.dart';

class ShareIconButton extends StatelessWidget {
  final VoidCallback? onTap;

  const ShareIconButton({this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      tooltip: "Share",
      icon: const Icon(Icons.share),
    );
  }
}
