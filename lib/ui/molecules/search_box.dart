import 'package:flutter/material.dart';
import 'package:messy_catalog_activity/ui/atoms/search_input.dart';
import 'package:messy_catalog_activity/ui/atoms/section_title.dart';

class SearchBox extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchBox({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Search Products'),
        const SizedBox(height: 8),
        SearchInput(onChanged: onChanged),
      ],
    );
  }
}
