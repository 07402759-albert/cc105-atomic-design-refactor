import 'package:flutter/material.dart';
import 'package:messy_catalog_activity/ui/atoms/delete_button.dart';
import 'package:messy_catalog_activity/ui/atoms/primary_button.dart';

class ProductActions extends StatelessWidget {
  final VoidCallback onAddToCart;
  final VoidCallback onDelete;

  const ProductActions({
    super.key,
    required this.onAddToCart,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryButton(label: 'Add to Cart', onPressed: onAddToCart),
        const SizedBox(height: 6),
        DeleteButton(onPressed: onDelete),
      ],
    );
  }
}
