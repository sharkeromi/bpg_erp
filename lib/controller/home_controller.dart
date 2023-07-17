import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  RxBool textScanning = false.obs;
  XFile? imageFile;
  RxString scannedText = RxString('');
  final RxBool isImageUploaded = RxBool(false);
  final RxBool isLoading = RxBool(false);
  final TextEditingController textEditor = TextEditingController();
  final RxBool isEditingMode = RxBool(false);
  final RxList imageList = RxList([]);

  final FocusNode textFocusNode = FocusNode();

  resetData() {
    isImageUploaded.value = false;
    isLoading.value = false;
    imageList.clear();
    scannedText.value = '';
    textScanning.value = false;
    imageFile = null;
  }

  getImage(ImageSource source) async {
    try {
      resetData();
      final pickedImage = await ImagePicker().pickImage(source: source);
      isLoading.value = true;
      if (pickedImage != null) {
        isImageUploaded.value = true;
        textScanning.value = true;
        imageFile = pickedImage;
        await getRecognisedText(pickedImage);
      }
    } catch (e) {
      isLoading.value = false;
      textScanning.value = false;
      imageFile = null;
      scannedText.value = "Error occured when scanning";
    }
  }

  getRecognisedText(XFile image) async {
    final languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);
    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognisedText =
        await textRecognizer.processImage(inputImage);
    await textRecognizer.close();
    List<String> textRows = [];
    String scanText = "";
    print(recognisedText.text);
    //scannedText.value = '';
    for (TextBlock block in recognisedText.blocks) {
      // print(block.lines.length);
      for (TextLine line in block.lines) {
        scanText += line.text + '\n';
        scannedText.value = scanText.trim();
      }
    }
    scannedText.value = scanText.trim();

    scannedText.value = scanText;
    // final String response =
    //     await languageIdentifier.identifyLanguage(scannedText.value);
    // final List<IdentifiedLanguage> possibleLanguages =
    //     await languageIdentifier.identifyPossibleLanguages(scannedText.value);
    // final IdentifiedLanguage mostLikelyLanguage = possibleLanguages.first;
    // print(mostLikelyLanguage.languageTag);
    imageList.add({'image': image.path, 'text': scannedText.value});
    textScanning.value = false;
    isLoading.value = false;
    log(imageList.toString());
  }

  toggleEditingMode() {
    if (isEditingMode.value == true) {
      scannedText.value = textEditor.text;
    } else {
      textEditor.text = scannedText.value;
      textFocusNode.requestFocus();
    }
    isEditingMode.value = !isEditingMode.value;
  }

  
}
