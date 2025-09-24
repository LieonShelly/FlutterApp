import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class _SvgAsset extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final Color? color;

  const _SvgAsset(
    this.assetPath, {
    this.width,
    this.height,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/$assetPath',
      width: width,
      height: height,
      color: color,
      package: 'component_library',
    );
  }
}

class OpeningQuoteSvgAsset extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;

  const OpeningQuoteSvgAsset({this.width, this.height, this.color, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SvgAsset(
      'opening-quote.svg',
      width: width,
      height: height,
      color: Colors.black,
    );
  }
}

class ClosingQuoteSvgAsset extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;

  const ClosingQuoteSvgAsset({this.width, this.height, this.color, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SvgAsset(
      'closing-quote.svg',
      width: width,
      height: height,
      color: Colors.black,
    );
  }
}
