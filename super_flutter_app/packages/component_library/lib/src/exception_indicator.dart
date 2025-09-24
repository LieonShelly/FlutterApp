import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExceptionIndicator extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onTryAgain;

  const ExceptionIndicator({
    this.title,
    this.message,
    this.onTryAgain,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 48),
            const SizedBox(height: Spacing.xxLarge),
            Text(
              title ?? "Something went wrong",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: FontSize.mediumLarge,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(title ?? 'Something went wrong', textAlign: TextAlign.center),
            if (onTryAgain != null) const SizedBox(height: Spacing.xxxLarge),
            if (onTryAgain != null)
              ExpandedElevatedButton(
                onTap: onTryAgain,
                icon: const Icon(Icons.refresh),
                label: 'Try Again',
              ),
          ],
        ),
      ),
    );
  }
}
