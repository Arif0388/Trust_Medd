import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:trust_medd/SplashPage/splash_page.dart';
import 'Config/theme.dart';
import 'add.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder:EasyLoading.init(),
      debugShowCheckedModeBanner:false,
      title: 'Trust Med',
      theme:lightTheme,
      home:const SplashPage(),
      // home:const WelcomePage(),
      // home:const HomePage(),
    );
  }
}
