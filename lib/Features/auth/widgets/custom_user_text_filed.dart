import 'package:flutter/material.dart';

class CustomUserTextField extends StatefulWidget {
  const CustomUserTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.isPassword = false,
    this.suffixIcon, this.keyboardType,
  });

  final TextEditingController controller;
  final String labelText;
  final bool isPassword;
  final Widget? suffixIcon;
  final keyboardType;

  @override
  State<CustomUserTextField> createState() => _CustomUserTextFieldState();
}

class _CustomUserTextFieldState extends State<CustomUserTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        obscureText: _obscureText,
        cursorColor: Colors.black54,
        cursorHeight: 20,
        style: const TextStyle(color: Colors.black87, fontSize: 16),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return '${widget.labelText} مطلوب';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: widget.labelText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : widget.suffixIcon,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          errorStyle: const TextStyle(color: Colors.redAccent),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.5),
            borderRadius: BorderRadius.circular(16),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
