import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StyledStatusBar extends StatelessWidget {
  final Widget child;
  final SystemUiOverlayStyle style;

  const StyledStatusBar._({required this.child, required this.style, Key? key})
    : super(key: key);

  const StyledStatusBar.light({required Widget child, Key? key})
    : this._(child: child, style: SystemUiOverlayStyle.light, key: key);

  const StyledStatusBar.dark({required Widget child, Key? key})
    : this._(child: child, style: SystemUiOverlayStyle.dark, key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(child: child, value: style);
  }
}
