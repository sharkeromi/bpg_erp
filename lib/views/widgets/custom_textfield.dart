import 'package:bpg_erp/utils/const/styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  final String? hintText;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  final Function(String)? onSubmitted;
  final FocusNode? focusNode;

  final int? maxLine, minLine;

  const CustomTextField({
    super.key,
    this.hintText,
    required this.controller,
    this.obscureText,
    this.textInputAction,
    this.onSubmitted,
    this.focusNode,
    this.maxLine = 1,
    this.minLine = 1,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: kTSExtractedText,
      focusNode: focusNode,
      onSubmitted: onSubmitted,
      obscureText: obscureText ?? false,
      minLines: minLine,
      maxLines: maxLine,
      onChanged: (value) {},
      textInputAction: textInputAction ?? TextInputAction.next,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(12, 6, 10, 12),
        hintText: hintText,
        hintStyle: kTSTextField,
        border: InputBorder.none,
      ),
    );
  }
}
