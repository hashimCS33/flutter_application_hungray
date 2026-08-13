import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';

class FoodCategory extends StatefulWidget {
  const FoodCategory({super.key, required this.category, required this.selectedIndex});
  final int selectedIndex;
  final List category;


  @override
  State<FoodCategory> createState() => _FoodCategoryState();
}

class _FoodCategoryState extends State<FoodCategory> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: List.generate(widget.category.length, (index) {
            final isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () => setState(() => _selectedIndex = index),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 27,
                ),
                child: CustomText(
                  text: widget.category[index],
                  color: isSelected ? Colors.white : Colors.black87,
                  fontweight: FontWeight.w500,
                  fontsize: 18,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
