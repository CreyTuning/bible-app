
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yhwh/classes/hiveManagers/HighlighterManager.dart';
import 'package:yhwh/data/Define.dart';
import 'package:yhwh/models/highlighterItem.dart';
import 'package:yhwh/widgets/VerseExplorer/VerseExplorerHighlighterWidget.dart';

class VerseExplorerController extends GetxController{

  List<int> arguments = Get.arguments;
  HighlighterItem highlighterItem;
  List<Widget> content = [];

  String title = '';
  int book;
  int chapter;
  int verse;

  @override
  void onInit() {
    book = arguments[0];
    chapter = arguments[1];
    verse = arguments[2];
    title = '${intToBook[book]} $chapter:$verse';

    update();
    super.onInit();
  }

  @override
  void onReady() async {
    Map chapterData = await HighlighterManager.getHighlightVersesInChapterWithData(book, chapter);
    highlighterItem = chapterData.containsKey(verse) ? chapterData[verse] : null;

    if(highlighterItem != null){
      content.add(VerseExplorerHighlighterWidget(
        highlighterItem: highlighterItem,
      ));
    }

    update();
    super.onReady();
  }
}