import 'package:flutter/material.dart';

import '../../core/resources/colors.dart';

const customButtonTextStyle =
    TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400);

class CustomElevatedButton extends StatelessWidget {
  final String? buttonText;
  final Function onTap;
  final double? borderRadius;
  final Color? fontColor;
  final double? fontSize;
  final double? height;
  final double? width;
  final FontWeight? fontWeight;
  final Widget? widget;
  final double? padding;
  final Color? color;
  final Color? borderColor;

  const CustomElevatedButton({
    super.key,
    required this.onTap,
    this.buttonText,
    this.borderRadius,
    this.fontColor,
    this.widget,
    this.width,
    this.fontWeight,
    this.height,
    this.borderColor,
    this.padding,
    this.fontSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding ?? 20),
      child: ElevatedButton(
        onPressed: () => onTap(),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(width ?? double.infinity, height ?? 48),
          elevation: 0,
          backgroundColor: color ?? AppColors.buttonColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor ?? AppColors.buttonColor),
            borderRadius: BorderRadius.circular(borderRadius ?? 6),
          ),
        ),
        child: widget ??
            Text(buttonText!,
                textAlign: TextAlign.center,
                style: customButtonTextStyle.copyWith(
                    fontWeight: fontWeight,
                    color: fontColor ?? Colors.white,
                    fontSize: fontSize)),
      ),
    );
  }
}
