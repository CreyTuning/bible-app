import 'package:flutter/material.dart';
import 'package:yhwh/ui_widgets/ui_verse.dart';

class Chapter {
  int number = 0;
  List<List> versos = List<List>();

  Chapter({this.number, this.versos});

  Future<void> fromMap(Map map) async
  {
    versos = List<List>();
    this.number = map['number'];

    for(int i = 0; i < map['verses'].length; i++){
      versos.add([i + 1, map['verses'][i]['text']]);
    }
  }
}
