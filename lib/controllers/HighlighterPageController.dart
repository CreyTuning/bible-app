import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:yhwh/controllers/BiblePageController.dart';
import 'package:yhwh/models/highlighterItem.dart';
import 'package:yhwh/models/highlighterOrderItem.dart';

class HighlighterPageController extends GetxController{
  LazyBox? highlighterBox;
  LazyBox? highlighterOrderBox;
  final int lazyListAddMoreItemCount = 20;
  List<HighlighterItem> data = [];

  @override
  void onInit() async { 
    highlighterBox = await Hive.openLazyBox('highlighterBox');
    highlighterOrderBox = await Hive.openLazyBox('highlighterOrderBox');
    super.onInit();
  }

  @override
  void onReady() async {
    await lazyAddMoreData();
    super.onReady();
  }

  Future<void> lazyAddMoreData() async {
    if(data.length < highlighterOrderBox!.length){
      int initialLength = data.length;

      for(int i = initialLength; i < limitNumber(initialLength + lazyListAddMoreItemCount, highlighterOrderBox!.length); i++){
        HighlighterOrderItem highlighterOrderItem = await highlighterOrderBox!.getAt(highlighterOrderBox!.length - 1 - i);
        Map contentChapterList = await highlighterBox!.get('${highlighterOrderItem.book}:${highlighterOrderItem.chapter}');
        
        data.add(contentChapterList[highlighterOrderItem.id]);
      }

      update();
    }
  }

  void removeToList(){
    // data.removeAt(0);
    // highlighterBox.delete(highlighterBox.length - 1);
    update();
  }

  void clearList() async {
    data.clear();
    await highlighterBox!.clear();
    await highlighterOrderBox!.clear();

    BiblePageController biblePageController = Get.find();
    await biblePageController.updateVerseList();
    biblePageController.update();

    update();
  }

  int limitNumber(int number, int limit) => number <= limit ? number : limit;
}