import 'package:flutter/material.dart';

class CartControl extends StatefulWidget {
  final void Function(int) addToCart;
  const CartControl({required this.addToCart, super.key});

  @override
  State<CartControl> createState() {
    return _CartControlState();
  }
}

class _CartControlState extends State<CartControl> {
  int _cartNumber = 1;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildMinusButtton(),
        _buildCartNumberContainer(colorScheme),
        _buildPlusButton(),
        const Spacer(),
        _buildAddCartButton(),
      ],
    );
  }

  Widget _buildMinusButtton() {
    return IconButton(
      onPressed: () {
        setState(() {
          if (_cartNumber > 1) {
            _cartNumber--;
          }
        });
      },
      icon: const Icon(Icons.remove),
      tooltip: "Decrease Cart Count",
    );
  }

  Widget _buildCartNumberContainer(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      color: colorScheme.onPrimary,
      child: Text(_cartNumber.toString()),
    );
  }

  Widget _buildPlusButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          _cartNumber++;
        });
      },
      icon: const Icon(Icons.add),
      tooltip: "Increase Cart Count",
    );
  }

  Widget _buildAddCartButton() {
    return FilledButton(
      onPressed: () {
        widget.addToCart(_cartNumber);
      },
      child: const Text("Add to Cart"),
    );
  }
}
