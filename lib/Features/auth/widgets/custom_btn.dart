import 'package:flutter/material.dart';

class CustomAuthBtn extends StatelessWidget {
  const CustomAuthBtn({
    super.key,
    required this.onTap,
    required this.text,
    required this.color,
    this.fontsize = 18,
    this.fontweight = FontWeight.w500,
    this.borderColor,
    this.backgroundColor = Colors.transparent,
    this.height = 50,
    this.width = double.infinity,
  });

  final VoidCallback onTap;
  final String text;
  final Color color;
  final double fontsize;
  final FontWeight fontweight;
  final Color? borderColor;
  final Color backgroundColor;
  final double height ;
  final double width ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide(color: borderColor ?? color, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: fontsize,
            fontWeight: fontweight,
          ),
        ),
      ),
    );
  }
}