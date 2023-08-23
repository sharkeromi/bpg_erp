import 'package:bpg_erp/Service/environment.dart';
import 'package:bpg_erp/controller/binder/getx_dependencies.dart';
import 'package:bpg_erp/utils/const/value.dart';
import 'package:bpg_erp/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  AllControllerBinder().dependencies();

  await dotenv.load(fileName: Environment.fileName);
  ll(Environment.fileName.toString());

  
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
    statusBarBrightness: Brightness.light,
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const Scanner());
  });
}

class Scanner extends StatelessWidget {
  const Scanner({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: GetMaterialApp(
        defaultTransition: Transition.noTransition,
        debugShowCheckedModeBanner: false,
        home: LogInScreen(),
      ),
    );
  }
}
