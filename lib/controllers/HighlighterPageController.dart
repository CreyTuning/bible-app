import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:yhwh/models/highlighterItem.dart';

class HighlighterPageController extends GetxController{
  LazyBox highlighterBox;
  List<HighlighterItem> data = [];

  @override
  void onInit() async { 
    highlighterBox = await Hive.openLazyBox('highlighterBox');

    for(int index = highlighterBox.length - 1; index >= 0; index--){
      data.add(await highlighterBox.get(index));
    }

    update();
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  void addToList(){
    data.insert(0, HighlighterItem(book: highlighterBox.length, chapter: 1, verses: [1, 2, 3], color: '#FFFFFF'));
    highlighterBox.put(highlighterBox.length, data.first);
    print(data);
    update();
  }

  void removeToList(){
    data.removeAt(0);
    highlighterBox.delete(highlighterBox.length - 1);
    update();
  }

  void clearList(){
    data.clear();
    highlighterBox.clear();
    update();
  }
}