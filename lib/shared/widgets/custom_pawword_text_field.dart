import 'package:flutter/material.dart';

// import 'package:flutter_svg/flutter_svg.dart';

import '../../core/resources/colors.dart';
import '../../core/resources/styles.dart';

class CustomPasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final Color fillColor;
  final Color borderColor;
  final String? prefixIcon;
  final String? suffixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputAction textInputAction;

  const CustomPasswordTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.fillColor = Colors.white,
    this.borderColor = AppColors.borderColor,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.textInputAction = TextInputAction.done,
  });

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscured,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        hintText: widget.hintText,
        contentPadding: EdgeInsets.zero,
        hintStyle: lightGrey15W400,
        labelStyle: lightGrey15W400,
        fillColor: widget.fillColor,
        prefixIconConstraints: const BoxConstraints(),
        filled: true,
        suffixIcon: IconButton(
          icon: Icon(
            _isObscured ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: widget.borderColor.withValues(alpha: 0.7)),
          borderRadius: BorderRadius.circular(6),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.redAccent,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      validator: widget.validator,
      onChanged: widget.onChanged,
    );
  }
}
