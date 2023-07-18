import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  final String hintText;

  const CustomTextField(
      {super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.grey.shade400, width: 1, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        obscureText: hintText == "Password" ? true : false,
        onChanged: (value) {},
        textInputAction: hintText == "Password"
            ? TextInputAction.done
            : TextInputAction.next,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(12, 6, 10, 12),
          hintText: hintText,
          hintStyle: hintText == 'URL (Optional)'
              ? const TextStyle(
                  fontFamily: 'Euclid Regular', color: Colors.black54)
              : const TextStyle(
                  fontFamily: 'Euclid Regular', color: Colors.black),
          border: InputBorder.none,
          fillColor: Colors.black,
        ),
      ),
    );
  }
}
