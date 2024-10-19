import 'package:get/get.dart';
import 'package:yhwh/classes/BibleManager.dart';
import 'package:yhwh/controllers/BiblePageController.dart';
import 'package:yhwh/models/highlighterItem.dart';

class HighlighterViewerController extends GetxController {
  HighlighterItem highlighterItem;
  List<List> verses = [];

  @override
  void onInit() {
    highlighterItem = Get.arguments;
    super.onInit();
  }

  @override
  void onReady() async {
    await initVerses();
    update();
    super.onReady();
  }

  Future<void> initVerses() async {
    for(int number in highlighterItem.verses){
      verses.add([number, await BibleManager().getVerse(book: highlighterItem.book, chapter: highlighterItem.chapter, verse: number)]);
    }
  }

  void showInBible(){
    BiblePageController _biblePageController = Get.find();
    _biblePageController.cancelSelectionModeOnTap();
    Get.back();
    Get.back();
    _biblePageController.setReferenceSafeScroll(highlighterItem.book, highlighterItem.chapter, highlighterItem.verses.first);
  }
}