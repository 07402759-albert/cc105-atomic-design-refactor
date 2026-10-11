import 'package:flutter/material.dart';
import 'package:messy_catalog_activity/ui/atoms/app_text_field.dart';
import 'package:messy_catalog_activity/utils/validators.dart';

class ProductNameField extends StatelessWidget {
  final TextEditingController controller;

  const ProductNameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: 'Product Name',
      validator: validateName,
    );
  }
}
