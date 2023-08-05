import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bpg_erp/controller/global_controller.dart';
import 'package:bpg_erp/views/widgets/delete_confirm_popup.dart';
import 'package:bpg_erp/views/widgets/image_picker_ad.dart';
import 'package:bpg_erp/views/widgets/reset_confirm_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  XFile? imageFile;
  final RxList<RxString> scannedTextList = RxList([''.obs]);
  final RxBool isEmptyLoading = RxBool(false);
  final RxList<TextEditingController> textEditorList = RxList([TextEditingController()]);
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController emailEditingController = TextEditingController();
  // final TextEditingController hangerPageNameEditingController = TextEditingController();
  // final TextEditingController hangerPageEmailEditingController = TextEditingController();
  final RxList<RxBool> isEditingModeList = RxList([false.obs]);
  final RxList imageList = RxList([]);
  final RxList<FocusNode> textFocusNodeList = RxList([FocusNode()]);
  RxBool isCardPageButtonEnabled = RxBool(false);
  RxBool isHangerPageButtonEnabled = RxBool(false);
  RxBool isSaveButtonEnabled = RxBool(false);

  final RxString origin = RxString('');

  nameEmailValidation() {
    if (nameEditingController.text.trim() != '' && emailEditingController.text.trim() != '') {
      isSaveButtonEnabled.value = true;
    } else {
      isSaveButtonEnabled.value = false;
    }
  }

  resetNameEmailField() {
    emailEditingController.clear();
    nameEditingController.clear();
  }

  resetData() {
    imageFile = null;
    imageList.clear();
    isEmptyLoading.value = false;
    isSaveButtonEnabled.value = false;
    isCardPageButtonEnabled.value = false;
    isHangerPageButtonEnabled.value = false;
    //Clear------------------
    scannedTextList.clear();
    textEditorList.clear();
    isEditingModeList.clear();
    textFocusNodeList.clear();
    emailEditingController.clear();
    nameEditingController.clear();
    //Initialize----------------
    scannedTextList.add(''.obs);
    textEditorList.add(TextEditingController());
    isEditingModeList.add(false.obs);
    textFocusNodeList.add(FocusNode());
  }

  Future<XFile?> cropImage(String imagePath) async {
    final File? croppedImage = await ImageCropper().cropImage(
      sourcePath: imagePath,
      maxWidth: 1000,
      maxHeight: 1000,
      compressFormat: ImageCompressFormat.png,
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.black,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
        cropGridRowCount: 2,
        cropGridColumnCount: 2,
        cropGridColor: Colors.grey,
      ),
      iosUiSettings: const IOSUiSettings(
        title: 'Crop Image',
      ),
    );
    if (croppedImage != null) {
      return XFile(croppedImage.path);
    } else {
      return null;
    }
  }

  final RxString base64Image = RxString('');
  Future<void> getImage(source, index) async {
    try {
      final XFile? pickedImage = await ImagePicker().pickImage(source: source);
      isEmptyLoading.value = true;
      if (pickedImage != null) {
        if (isCardPageButtonEnabled.value == true || isHangerPageButtonEnabled.value == true) {
          isCardPageButtonEnabled.value = false;
          isHangerPageButtonEnabled.value = false;
        }
        final List<int> imageBytes = await pickedImage.readAsBytes();
        base64Image.value = 'data:image/png;base64,${base64Encode(imageBytes)}';
        final XFile? croppedImage = await cropImage(pickedImage.path);
        if (croppedImage != null) {
          imageFile = croppedImage;
          await getRecognizedText(croppedImage, index);
        } else {
          if ((isCardPageButtonEnabled.value == false || isHangerPageButtonEnabled.value == false) && isSaveButtonEnabled.value == true) {
            isCardPageButtonEnabled.value = true;
            isHangerPageButtonEnabled.value = true;
          }
          isEmptyLoading.value = false;
          imageFile = null;
        }
      } else {
        if ((isCardPageButtonEnabled.value == false || isHangerPageButtonEnabled.value == false) && isSaveButtonEnabled.value == true) {
          isCardPageButtonEnabled.value = true;
          isHangerPageButtonEnabled.value = true;
        }
        isEmptyLoading.value = false;
        imageFile = null;
        scannedTextList[index].value = "Error occurred when selecting image";
      }
    } catch (e) {
      isEmptyLoading.value = false;
      imageFile = null;
      scannedTextList[index].value = "Error occurred when scanning";
    }
  }

  getRecognizedText(XFile image, int index) async {
    final InputImage inputImage = InputImage.fromFilePath(image.path);
    final TextRecognizer textRecognizer = TextRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    await textRecognizer.close();
    String scanText = "";
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        if (line.text.contains('Technical Info:') || line.text.contains('DIA') || origin.value == "card" || origin.value == "") {
          scanText += '${line.text}\n';
        } else {
          scanText += line.text;
        }
        // log("Line : " + line.text);
      }
    }
    var returnData = Get.find<GlobalController>().stringManipulation(scanText);
    scannedTextList[index].value = returnData;
    resetEdit();
    isEmptyLoading.value = false;
    imageList.add({
      // 'name': nameEditingController.text.trim(),
      // 'email': emailEditingController.text.trim(),
      'image': image.path,
      'text': scannedTextList[index].value,
      'base64Image': base64Image.value.toString()
    });
    scannedTextList.add(''.obs);
    textEditorList.add(TextEditingController());
    textFocusNodeList.add(FocusNode());
    isEditingModeList.add(false.obs);
  }

  resetEdit() {
    for (int i = imageList.length - 1; i >= 0; i--) {
      if (isEditingModeList[i].value) {
        scannedTextList[i].value = textEditorList[i].text;
        imageList[i]['text'] = textEditorList[i].text;
        isEditingModeList[i].value = false;
      }
    }
  }

  deleteData(index) {
    imageList.removeAt(index);
    scannedTextList.removeAt(index);
    textEditorList.removeAt(index);
    isEditingModeList.removeAt(index);
    textFocusNodeList.removeAt(index);
    isCardPageButtonEnabled.value = false;
    isHangerPageButtonEnabled.value = false;
  }

  toggleEditingMode(index) {
    if (isEditingModeList[index].value == true) {
      if (isSaveButtonEnabled.value == true) {
        isCardPageButtonEnabled.value = true;
        isHangerPageButtonEnabled.value = true;
      }
      scannedTextList[index].value = textEditorList[index].text;
      imageList[index]['text'] = textEditorList[index].text;
    } else {
      textEditorList[index].text = scannedTextList[index].value;
      if (isSaveButtonEnabled.value == true) {
        isCardPageButtonEnabled.value = false;
        isHangerPageButtonEnabled.value = false;
      }
      textFocusNodeList[index].requestFocus();
    }
    isEditingModeList[index].value = !isEditingModeList[index].value;
  }

  //* Popup Functions
  void showCustomDialog(BuildContext context, [index]) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ImagePickerAD(
            index: index,
            homeController: Get.find<HomeController>(),
          ),
        );
      },
    );
  }

  void showDeleteDialog(BuildContext context, index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: DeleteConfirmPopUp(
            index: index,
          ),
        );
      },
    );
  }

  void showResetConfirmDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ResetConfirmPopUp(),
        );
      },
    );
  }
}
