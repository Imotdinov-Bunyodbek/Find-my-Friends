import 'package:find_friend/util/firebase_options.dart';
import 'package:find_friend/data/model/my_hive.dart';
import 'package:find_friend/presentation/main_controller.dart';
import 'package:find_friend/ui/home_screen.dart';
import 'package:find_friend/ui/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'data/model/location_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await MyHiveHelper.init();
  if (!await LocationService().checkPermission()) {
    LocationService().requestPermission();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final user = MyHiveHelper().getUser();
  final controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find Friends',
      debugShowCheckedModeBanner: false,
      theme: controller.isDark.value
          ? ThemeData.dark(useMaterial3: true)
          : ThemeData.light(useMaterial3: true),
      home: user.name != "" ? HomeScreen() : LoginScreen(),
    );
  }
}
