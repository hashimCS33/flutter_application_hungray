import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text, this.color, this.fontweight, this.fontsize});

  final String text;
  final Color? color;
  final FontWeight? fontweight;
  final double? fontsize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontsize,
        fontWeight: fontweight,
        color: color,
      ),
    );
  }
}
