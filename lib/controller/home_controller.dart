import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  RxBool textScanning = false.obs;
  XFile? imageFile;
  RxString scannedText = RxString('');

  getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning.value = true;
        imageFile = pickedImage;
        await getRecognisedText(pickedImage);
      }
    } catch (e) {
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
    final String response =
        await languageIdentifier.identifyLanguage(scannedText.value);
    final List<IdentifiedLanguage> possibleLanguages =
        await languageIdentifier.identifyPossibleLanguages(scannedText.value);
    final IdentifiedLanguage mostLikelyLanguage = possibleLanguages.first;
    print(mostLikelyLanguage.languageTag);
    textScanning.value = false;
  }


}