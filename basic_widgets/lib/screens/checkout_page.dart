import 'package:basic_widgets/models/cart_manager.dart';
import 'package:basic_widgets/models/order_manager.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  final CartManager cartManager;
  final Function didUpdate;
  final Function(Order) onSubmit;

  const CheckoutPage({
    super.key,
    required this.cartManager,
    required this.didUpdate,
    required this.onSubmit,
  });

  @override
  State<CheckoutPage> createState() {
    return _CheckoutPageState();
  }
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(
      context,
    ).textTheme.apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
