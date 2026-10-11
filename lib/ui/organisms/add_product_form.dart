import 'package:flutter/material.dart';
import 'package:messy_catalog_activity/constants/categories.dart';
import 'package:messy_catalog_activity/ui/atoms/primary_button.dart';
import 'package:messy_catalog_activity/ui/atoms/section_title.dart';
import 'package:messy_catalog_activity/ui/molecules/product_category_field.dart';
import 'package:messy_catalog_activity/ui/molecules/product_description_field.dart';
import 'package:messy_catalog_activity/ui/molecules/product_name_field.dart';
import 'package:messy_catalog_activity/ui/molecules/product_price_field.dart';

// the form only gives back the values, the page decides what to do with them
typedef ProductSubmitCallback = void Function(
  String name,
  double price,
  String category,
  String description,
);

class AddProductForm extends StatefulWidget {
  final ProductSubmitCallback onSubmit;

  const AddProductForm({super.key, required this.onSubmit});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedCategory = defaultCategory;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final name = _nameController.text;

    widget.onSubmit(
      name,
      double.parse(_priceController.text),
      _selectedCategory,
      _descriptionController.text,
    );

    // reset the form
    setState(() {
      _nameController.clear();
      _priceController.clear();
      _descriptionController.clear();
      _selectedCategory = defaultCategory;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name added to catalog!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Add New Product'),
        const SizedBox(height: 12),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductNameField(controller: _nameController),
              const SizedBox(height: 12),
              ProductPriceField(controller: _priceController),
              const SizedBox(height: 12),
              ProductCategoryField(
                value: _selectedCategory,
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value ?? defaultCategory;
                  });
                },
              ),
              const SizedBox(height: 12),
              ProductDescriptionField(controller: _descriptionController),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  label: 'Submit Product',
                  onPressed: _submit,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
