import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double? width;
  final Widget widget;
  final VoidCallback? navigation;
  final Color? color;
  final Gradient? gradient;

  const CustomButton({
    super.key,
    required this.widget,
    required this.height,
    this.width,
    required this.navigation,
    this.color,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // <-- Radius
        ),
      ),
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
    );
  }
}
