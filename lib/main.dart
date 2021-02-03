import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:yhwh/classes/AppTheme.dart';
import 'package:yhwh/pages/MainPage.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  // Init GetStorage
  await GetStorage.init();

  // Init Hive
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  // Run Application
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainPage(),
    theme: AppTheme.light,
    darkTheme: AppTheme.dark,
    builder: (context, child) => ScrollConfiguration(behavior: _MyBehavior(), child: child), // remove the glow effect.
  ));
}

// remove the glow effect.
class _MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) => child;
}