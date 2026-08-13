import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';
import 'package:gap/gap.dart';

class SpicySlider extends StatelessWidget {
  const SpicySlider({super.key, required double sliderValue, required ValueChanged<double> onSliderChanged})
      : value = sliderValue,
        _onChanged = onSliderChanged;

  final double value;
  final ValueChanged<double> _onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/detail/sandwitch_detail.png', height: 250),
        Spacer(),
        Column(
          children: [
            CustomText(
              text:
                  'Customize Your Burger\n to Your Tastes.\n Ultimate Experience',
              fontweight: FontWeight.bold,
            ),

            Slider(
              min: 0,
              max: 1,
              value: value,
              onChanged: _onChanged,
              inactiveColor: Colors.grey.shade300,
              activeColor: AppColors.primary,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: '🥶', color: Colors.grey),
                Gap(100),
                CustomText(text: '🌶️', color: Colors.grey),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
