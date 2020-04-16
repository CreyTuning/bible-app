import 'package:yhwh/pages/BookSelection.dart';
import 'package:yhwh/pages/HomePage.dart';
import 'package:flutter/material.dart';


final routes = {
  'home': (BuildContext buildContext) => HomePage(),
  'books' : (BuildContext buildContext) => BookSelection(),
};

Map<String, dynamic> getRoutes() => routes;