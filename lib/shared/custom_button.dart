import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final Color? color;
  final double? height;
  final double? radius;

  const CustomButton({super.key, required this.text,  required this.onPressed, this.width, this.color, this.height, this.radius});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 14)),
        ),
      child: CustomText(
        text: text,
        color: Colors.white,
        fontweight: FontWeight.bold,
        fontsize: 16,
     
      ),
      ),
    );
  }
}
