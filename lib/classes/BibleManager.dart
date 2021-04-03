import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
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
    Directory dir = await getExternalStorageDirectory();
    LazyBox box = await Hive.openLazyBox('rvr60', path: dir.path);

    for(int i = 0; i < valuesOfBooks[book - 1][chapter - 1]; i++){
      output.add(await box.get('$book:$chapter:${i + 1}'));
    }

    return output;
  }

  Future<String> getVerse({int book, int chapter, int verse}) async {
    Directory dir = await getExternalStorageDirectory();
    LazyBox box = await Hive.openLazyBox('rvr60', path: dir.path);

    return await box.get('$book:$chapter:$verse');
  }
}