import 'package:bpg_erp/utils/const/styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  final String? hintText;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextStyle? hintTextStyle;
  final Function(String)? onSubmitted, onChanged;
  final FocusNode? focusNode;

  final int? maxLine, minLine;

  const CustomTextField({
    super.key,
    this.hintText,
    required this.controller,
    this.obscureText,
    this.textInputAction,
    this.onSubmitted,
    this.onChanged,
    this.hintTextStyle,
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
      textAlignVertical: TextAlignVertical.center,
      obscureText: obscureText ?? false,
      minLines: minLine,
      maxLines: maxLine,
      onChanged: onChanged,
      textInputAction: textInputAction ?? TextInputAction.next,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(12, 6, 10, 6),
        hintText: hintText,
        border: const OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(30))),
        hintStyle: hintTextStyle ?? kTSTextField,
        // border: InputBorder.none,
      ),
    );
  }
}
