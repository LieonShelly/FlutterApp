import 'package:flutter/widgets.dart';

class ShrinkableText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const ShrinkableText({
    required this.text,
    this.style,
    this.textAlign = TextAlign.center,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style, textAlign: textAlign);
  }
}
