import 'package:flutter/material.dart';
import 'package:fullcycle/core/resources/colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, this.indent = 0});

  final double indent;

  @override
  Widget build(BuildContext context) {
    return Divider(
        thickness: 1,
        endIndent: indent,
        indent: indent,
        color: AppColors.dividerColor.withValues(alpha: 0.3));
  }
}
