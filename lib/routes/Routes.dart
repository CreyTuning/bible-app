import 'package:yhwh/pages/BibleInformation.dart';
import 'package:yhwh/pages/BookSelection.dart';
import 'package:yhwh/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:yhwh/pages/StylePage.dart';


final routes = {
  'home': (BuildContext buildContext) => HomePage(),
  'books' : (BuildContext buildContext) => BookSelection(),
  'bible_information' : (BuildContext buildContext) => BibleInformation(),
  'styles' : (BuildContext buildContext) => StylePage(),
};

Map<String, dynamic> getRoutes() => routes;