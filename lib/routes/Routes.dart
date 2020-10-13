import 'package:yhwh/pages/BiblePage/BibleInformation.dart';
import 'package:yhwh/pages/BiblePage/BiblePage.dart';
import 'package:flutter/material.dart';
import 'package:yhwh/pages/BiblePage/StylePage/StylePage.dart';


final routes = {
  'bible_page': (BuildContext buildContext) => BiblePage(),
  'bible_information' : (BuildContext buildContext) => BibleInformation(),
  'styles' : (BuildContext buildContext) => StylePage(),
};

Map<String, dynamic> getRoutes() => routes;