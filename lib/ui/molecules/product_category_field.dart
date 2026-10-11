import 'package:flutter/material.dart';
import 'package:messy_catalog_activity/constants/categories.dart';
import 'package:messy_catalog_activity/ui/atoms/category_dropdown.dart';

class ProductCategoryField extends StatelessWidget {
  final String value;
  final ValueChanged<String?> onChanged;

  const ProductCategoryField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CategoryDropdown(
      value: value,
      categories: productCategories,
      onChanged: onChanged,
    );
  }
}
