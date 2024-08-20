import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:yhwh/bibles/rvr60.dart';
import 'package:yhwh/data/valuesOfBooks.dart';

class BibleManager{

  BibleManager();
  
  Future<List<String>> getChapterVerses(String version, int book, int chapter) async {
    List<String> output = [];
    List data = await jsonDecode(await rootBundle.loadString('lib/bibles/$version/${book}_$chapter.json'))['verses'];

    for(var map in data){
      output.add(map['text']);
    }

    return output;
  }

  Future<List<String>> getChapter({int book, int chapter}) async {
    List<String> output = [];

    for(int i = 0; i < valuesOfBooks[book - 1][chapter - 1]; i++)
      output.add(rvr60['$book:$chapter:${i + 1}']);

    return output;
  }

  Future<String> getVerse({int book, int chapter, int verse}) async {
    return rvr60['$book:$chapter:$verse'];
  }
}