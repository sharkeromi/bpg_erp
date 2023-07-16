import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final Widget widget;
  var navigation;

  CustomButton(
      {super.key,
      required this.widget,
      required this.height,
      required this.width,
      required this.navigation});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
      ),
      onPressed: navigation,
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF60CCD9),
              Color(0xFF0096b5),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        height: height,
        width: width,
        child: Center(child: widget),
      ),
    );
  }
}
