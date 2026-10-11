import 'package:flutter/material.dart';
import 'package:messy_catalog_activity/ui/atoms/app_text_field.dart';

class ProductDescriptionField extends StatelessWidget {
  final TextEditingController controller;

  const ProductDescriptionField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: 'Description',
      maxLines: 3,
      alignLabelWithHint: true,
    );
  }
}
