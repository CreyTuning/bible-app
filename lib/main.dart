import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:yhwh/classes/AppTheme.dart';
import 'package:yhwh/models/highlighterItem.dart';
import 'package:yhwh/models/highlighterOrderItem.dart';
import 'package:yhwh/pages/MainPage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  // Init GetStorage
  await GetStorage.init();

  // Init Hive
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive..init(appDocumentDir.path)
      .. registerAdapter(HighlighterItemAdapter())
      .. registerAdapter(HighlighterOrderItemAdapter());

  // Run Application
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainPage(),
    themeMode: ThemeMode.light,
    theme: AppTheme.black, // ACTUALIZAR ESTO
    darkTheme: AppTheme.black,
    builder: (context, child) => ScrollConfiguration(behavior: MyBehavior(), child: child!), // remove the glow effect.
  ));
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

