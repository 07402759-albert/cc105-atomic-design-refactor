import 'package:flutter/material.dart';
import 'package:messy_catalog_activity/ui/atoms/product_category_text.dart';
import 'package:messy_catalog_activity/ui/atoms/product_name_text.dart';
import 'package:messy_catalog_activity/ui/atoms/product_price_text.dart';

class ProductInfo extends StatelessWidget {
  final String name;
  final String category;
  final double price;

  const ProductInfo({
    super.key,
    required this.name,
    required this.category,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductNameText(name),
        const SizedBox(height: 4),
        ProductCategoryText(category),
        const SizedBox(height: 4),
        ProductPriceText(price),
      ],
    );
  }
}
