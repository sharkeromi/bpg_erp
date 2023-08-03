import 'package:bpg_erp/utils/const/styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double? width;
  final Widget widget;
  final VoidCallback? navigation;
  final Color? color;
  final Gradient? gradient;
  final bool? isButtonDisabled;

  const CustomButton({
    super.key,
    required this.widget,
    required this.height,
    this.width,
    required this.navigation,
    this.color,
    this.gradient,
    this.isButtonDisabled
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: TextButton(
        style: kTextButtonStyleDefault,
        onPressed: navigation,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            gradient: gradient,
            borderRadius: const BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          height: height,
          width: width,
          child: Center(child: widget),
        ),
      ),
    );
  }
}
