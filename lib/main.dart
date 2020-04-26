import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:yhwh/pages/MyApp.dart';
import 'package:flutter/material.dart';
import 'package:yhwh/data/Data.dart';
import 'package:yhwh/pages/StylePage.dart';

void main(){

  appData = Data();

  runApp(Phoenix(
    child: MyApp(),
  ));
}