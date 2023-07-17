import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final Widget widget;
  final VoidCallback? navigation;
  Color? color;
  var gradient;

  CustomButton(
      {super.key,
      required this.widget,
      required this.height,
      required this.width,
      required this.navigation,
      this.color,
      this.gradient});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25), // <-- Radius
        ),
      ),
      onPressed: navigation,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          // boxShadow: [
          //   BoxShadow(
          //       color: Color(ColorUtil.instance.hexColor("#dde1e4")),
          //       spreadRadius: 1,
          //       blurRadius: 4,
          //       offset: Offset(5, 5)),
          //   BoxShadow(
          //       color: Colors.white,
          //       spreadRadius: 1,
          //       blurRadius: 8,
          //       offset: Offset(-1, -1))
          // ],
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
