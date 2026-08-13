import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Material(
        elevation: 10,
        shadowColor: Colors.grey.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(15),
        child: TextField(
          focusNode: FocusNode(),
          decoration: InputDecoration(
            hintText: "Search for food",
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
