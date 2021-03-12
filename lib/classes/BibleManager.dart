import 'dart:convert';
import 'package:flutter/services.dart';

class BibleManager{

  BibleManager();
  
  getChapterVerses(String version, int book, int chapter) async {
    List<String> output = [];
    List data = await jsonDecode(await rootBundle.loadString('lib/bibles/$version/${book}_$chapter.json'))['verses'];

    for(var map in data){
      output.add(map['text']);
    }

    return output;
  }
}