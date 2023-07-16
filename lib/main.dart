import 'package:bpg_erp/views_beta/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:bpg_erp/views/bgp_login_page.dart';
import 'package:bpg_erp/views/practice_page.dart';
import 'package:bpg_erp/views/welcome_screen.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light, // For Android (dark icons)
    statusBarBrightness: Brightness.dark,
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(Scanner());
  });
}

class Scanner extends StatelessWidget {
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: LogInScreen(),
    );
  }
}