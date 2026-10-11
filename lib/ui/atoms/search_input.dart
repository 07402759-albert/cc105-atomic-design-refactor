import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchInput({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: const InputDecoration(
        hintText: 'Type a product name...',
      ),
    );
  }
}
