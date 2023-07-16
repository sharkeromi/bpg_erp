import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final Widget widget;
  final VoidCallback? navigation;

  const CustomButton({super.key, required this.widget, required this.height, required this.width, required this.navigation});

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
