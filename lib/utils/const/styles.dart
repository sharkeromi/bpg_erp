import 'package:bpg_erp/utils/const/color.dart';
import 'package:flutter/material.dart';

//* Text Styles
const extractedTextStyle = TextStyle(fontSize: 20);
const popUpHeaderStyle = TextStyle(fontSize: 18, color: whiteColor);
const logInScreenHeaderStyle =
    TextStyle(fontSize: 40, color: Colors.black38, fontWeight: FontWeight.bold);
const textStyle =
    TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black);
const boldTextStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
const kSAppBarPrefix = TextStyle(color: Colors.white, fontSize: 16);
const kSPopUpMessage = TextStyle(fontWeight: FontWeight.w400, fontSize: 16);
const kSDefaultStyle = TextStyle(color: Colors.white, fontSize: 20);

//* Sized Boxes
const kSizedBox10 = SizedBox(height: 10);
const kSizedBox20 = SizedBox(height: 20);
const kSizedBox40 = SizedBox(height: 40);
const kSizedBox50 = SizedBox(height: 50);
const kSizedBox80 = SizedBox(height: 80);

//* text button style
final ButtonStyle kTextButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(backgroundColor),
  foregroundColor: MaterialStateProperty.all(blackColor),
  padding: MaterialStateProperty.all(EdgeInsets.zero),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);

final kTextButtonStyleDefault = TextButton.styleFrom(
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    padding: EdgeInsets.zero,
    minimumSize: Size.zero,
    splashFactory: InkSplash.splashFactory);
