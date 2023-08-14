import 'package:bpg_erp/utils/const/color.dart';
import 'package:flutter/material.dart';

//* Text Styles
const kTSExtractedText = TextStyle(fontSize: 20);
const kTSPopUpHeader = TextStyle(fontSize: 18, color: kCWhite);
const kTSLogInScreenHeader = TextStyle(fontSize: 28, color: Colors.black38, fontWeight: FontWeight.bold);
const kTSDefault1 = TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black);
const kTSDefaultBold = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
const kTSAppBarPrefix = TextStyle(color: Colors.white, fontSize: 16);
const kTSPopUpMessage = TextStyle(fontWeight: FontWeight.w400, fontSize: 16);
const kTSDefaultStyle = TextStyle(color: Colors.white, fontSize: 20);
const kTSTextField = TextStyle(fontFamily: 'Euclid Regular', color: Colors.black54);
const kTSTextField2 = TextStyle(fontFamily: 'Euclid Regular', color: Colors.black54, fontSize: 18);

//* Sized Boxes
const kSizedBox10 = SizedBox(height: 10);
const kSizedBox20 = SizedBox(height: 20);
const kSizedBox40 = SizedBox(height: 40);
const kSizedBox50 = SizedBox(height: 50);
const kSizedBox80 = SizedBox(height: 80);

//* text button style
final ButtonStyle kTextButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(kCBackgroundColor),
  foregroundColor: MaterialStateProperty.all(kCBlack),
  padding: MaterialStateProperty.all(EdgeInsets.zero),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);

final kTextButtonStyleDefault = TextButton.styleFrom(
    tapTargetSize: MaterialTapTargetSize.shrinkWrap, padding: EdgeInsets.zero, minimumSize: Size.zero, splashFactory: InkSplash.splashFactory);

final kTextFieldDecoration = BoxDecoration(
  border: Border.all(color: Colors.grey.shade400, width: 1, style: BorderStyle.solid),
  borderRadius: BorderRadius.circular(20),
);
