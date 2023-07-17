import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  
  final Widget prefixWidget;
  
  final VoidCallback prefixWidgetAction;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.prefixWidget,
    required this.prefixWidgetAction
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF0096b5),
      title:  Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
          ),
          onPressed: prefixWidgetAction,
          child:  Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: prefixWidget
          ),
        ),
      ],
    );
  }
}
