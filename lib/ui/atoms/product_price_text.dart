import 'package:flutter/material.dart';

class ProductPriceText extends StatelessWidget {
  final double price;

  const ProductPriceText(this.price, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'PHP ${price.toStringAsFixed(2)}',
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.indigo,
      ),
    );
  }
}
