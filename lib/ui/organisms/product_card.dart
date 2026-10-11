import 'package:flutter/material.dart';
import 'package:messy_catalog_activity/models/product.dart';
import 'package:messy_catalog_activity/ui/atoms/product_icon_box.dart';
import 'package:messy_catalog_activity/ui/molecules/product_actions.dart';
import 'package:messy_catalog_activity/ui/molecules/product_info.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onDelete;

  const ProductCard({
    super.key,
    required this.product,
    required this.onDelete,
  });

  void _showCartMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Added ${product.name} to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ProductIconBox(icon: product.icon),
          const SizedBox(width: 12),
          Expanded(
            child: ProductInfo(
              name: product.name,
              category: product.category,
              price: product.price,
            ),
          ),
          ProductActions(
            onAddToCart: () => _showCartMessage(context),
            onDelete: onDelete,
          ),
        ],
      ),
    );
  }
}
