import 'package:flutter/material.dart';

import '../../core/resources/colors.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key, this.color, this.padding});

  final Color? color;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: padding ?? 0),
      child: Center(
          child: CircularProgressIndicator.adaptive(backgroundColor: color)),
    );
  }
}

class CustomLoadingButtonWidget extends StatelessWidget {
  const CustomLoadingButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          elevation: 0,
          backgroundColor: AppColors.buttonColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: const CircularProgressIndicator.adaptive(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
