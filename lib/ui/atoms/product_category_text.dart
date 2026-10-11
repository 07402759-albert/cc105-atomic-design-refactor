import 'package:flutter/material.dart';

class ProductCategoryText extends StatelessWidget {
  final String category;

  const ProductCategoryText(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      category,
      style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
    );
  }
}
