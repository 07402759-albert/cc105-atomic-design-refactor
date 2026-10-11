import 'package:flutter/material.dart';
import 'package:messy_catalog_activity/models/product.dart';
import 'package:messy_catalog_activity/ui/atoms/section_title.dart';
import 'package:messy_catalog_activity/ui/organisms/product_card.dart';

class CatalogList extends StatelessWidget {
  final List<Product> products;
  final void Function(Product product) onDelete;

  const CatalogList({
    super.key,
    required this.products,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Catalog'),
        const SizedBox(height: 8),
        Column(
          children: products.map((product) {
            return ProductCard(
              product: product,
              onDelete: () => onDelete(product),
            );
          }).toList(),
        ),
      ],
    );
  }
}
