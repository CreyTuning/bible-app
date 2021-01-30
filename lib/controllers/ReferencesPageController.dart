import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:yhwh/controllers/BiblePageController.dart';

class ReferencesPageController extends GetxController {
  PageController pageController;
  AutoScrollController bookAutoScrollController;
  AutoScrollController chapterAutoScrollController;
  AutoScrollController verseAutoScrollController;
  double buttonHeight = 60.0;
  int scrollItemDistance = 6;

  @override
  void onInit() {
    pageController = PageController();
    bookAutoScrollController = AutoScrollController();
    chapterAutoScrollController = AutoScrollController();
    verseAutoScrollController = AutoScrollController();
    super.onInit();
  }

  @override
    void onReady() {
      BiblePageController biblePageController = Get.find();
      bookAutoScrollController.scrollToIndex(biblePageController.bookNumber - 1, preferPosition: AutoScrollPosition.middle);
      chapterAutoScrollController.scrollToIndex(biblePageController.chapterNumber - 1, preferPosition: AutoScrollPosition.middle);
      verseAutoScrollController.scrollToIndex(biblePageController.verseNumber - 1, preferPosition: AutoScrollPosition.middle);
      super.onReady();
    }

  void bookListOnSelect(int index){
    bookAutoScrollController.scrollToIndex(index, preferPosition: AutoScrollPosition.middle);
  }

  void chapterListOnSelect(int index){
    chapterAutoScrollController.scrollToIndex(index, preferPosition: AutoScrollPosition.middle);
  }

  void verseListOnSelect(int index){
    verseAutoScrollController.scrollToIndex(index, preferPosition: AutoScrollPosition.middle);
  }
}