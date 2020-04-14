import 'package:bbnew/routes/Routes.dart' as Routes;
import 'package:flutter/material.dart';

import 'HomePage.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: Routes.getRoutes()
    );
  }
}