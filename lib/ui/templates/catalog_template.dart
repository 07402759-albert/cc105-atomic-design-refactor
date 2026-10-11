import 'package:flutter/material.dart';

// only layout here, the page gives the actual widgets
class CatalogTemplate extends StatelessWidget {
  final PreferredSizeWidget appBar;
  final Widget search;
  final Widget catalog;
  final Widget form;

  const CatalogTemplate({
    super.key,
    required this.appBar,
    required this.search,
    required this.catalog,
    required this.form,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            search,
            const SizedBox(height: 16),
            catalog,
            const Divider(height: 32, thickness: 1),
            form,
          ],
        ),
      ),
    );
  }
}
