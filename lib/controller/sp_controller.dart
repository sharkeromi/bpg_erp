import 'dart:convert';
import 'dart:developer';
import 'package:bpg_erp/utils/const/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  // save data
  Future<void> saveImageData(value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String encodedData = json.encode(value);
    log("Saved data : $encodedData");
    await preferences.setString(kImageDataKey, encodedData);
  }

  getImageData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? data = preferences.getString(kImageDataKey);
    var decodeData = (data == null) ? [] : json.decode(data);
    return decodeData;
  }

  //Delete Cache
  removeCache() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(kImageDataKey);
  }
}
