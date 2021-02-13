import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:yhwh/controllers/BiblePageController.dart';
import 'package:yhwh/data/Define.dart';
import 'package:diacritic/diacritic.dart';
import 'package:yhwh/data/valuesOfBooks.dart';

class ReferencesPageController extends GetxController {
  PageController pageController;
  AutoScrollController bookAutoScrollController;
  AutoScrollController chapterAutoScrollController;
  AutoScrollController verseAutoScrollController;
  double buttonHeight = 60.0;
  int scrollItemDistance = 6;

  // Search view
  List<List<int>> searchList = [];
  TextEditingController textEditingController;
  ScrollController searchListScrollController;

  @override
  void onInit() {
    pageController = PageController();
    searchListScrollController = ScrollController();
    bookAutoScrollController = AutoScrollController();
    chapterAutoScrollController = AutoScrollController();
    verseAutoScrollController = AutoScrollController();
    textEditingController = TextEditingController();
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

  void searchTextFieldOnChange(String text){
    searchList.clear();
    String clearText = text.trim();
    searchListScrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);

    // El texto esta vacio
    if(text.isEmpty){
      update();
      return;
    }

    // El tecto no esta vacio
    else if(text.isNotEmpty){

      // CONTIENE ESPACIOS
      if(clearText.contains(' ')){
        List<String> split = clearText.split(' ');

        // LIBRO + CHAPTER
        if(split.length == 2 && split[0].isAlphabetOnly && split[1].isNum){
          for(int i = 0; i < 66; i++){
            if(removeDiacritics(intToBook[i + 1]).isCaseInsensitiveContains(removeDiacritics(split[0]))){
              searchList.add([i + 1, valuesOfBooksChapterAdjuster(i + 1, int.parse(split[1])), 1]);
            }
          }
        }

        // LIBRO + CHAPTER + VERSE
        else if(split.length == 3 && split[0].isAlphabetOnly && split[1].isNum && split[2].isNum){
          for(int i = 0; i < 66; i++){
            if(removeDiacritics(intToBook[i + 1]).isCaseInsensitiveContains(removeDiacritics(split[0]))){
              searchList.add([i + 1, valuesOfBooksChapterAdjuster(i + 1, int.parse(split[1])), valuesOfBooksVerseAdjuster(i + 1, valuesOfBooksChapterAdjuster(i + 1, int.parse(split[1])), int.parse(split[2])) ]);
            }
          }
        }

        // LIBRO + CHAPTER + VERSE
        else if(split.length == 3 && split[0].isAlphabetOnly && split[1].isNum && split[2].isNum){
          for(int i = 0; i < 66; i++){
            if(removeDiacritics(intToBook[i + 1]).isCaseInsensitiveContains(removeDiacritics(split[0]))){
              searchList.add([i + 1, valuesOfBooksChapterAdjuster(i + 1, int.parse(split[1])), valuesOfBooksVerseAdjuster(i + 1, valuesOfBooksChapterAdjuster(i + 1, int.parse(split[1])), int.parse(split[2]))]);
            }
          }
        }

        // NUMBER + LIBRO
        else if(split.length == 2 && split[0].isNum && split[1].isAlphabetOnly){
          for(int i = 0; i < 66; i++){
            if(removeDiacritics(intToBook[i + 1]).isCaseInsensitiveContains(removeDiacritics('${split[0]} ${split[1]}'))){
              searchList.add([i + 1, 1, 1]);
            }
          }
        }

        // NUMBER + LIBRO + CHAPTER
        else if(split.length == 3 && split[0].isNum && split[1].isAlphabetOnly && split[2].isNum){
          for(int i = 0; i < 66; i++){
            if(removeDiacritics(intToBook[i + 1]).isCaseInsensitiveContains(removeDiacritics('${split[0]} ${split[1]}'))){
              searchList.add([i + 1, valuesOfBooksChapterAdjuster(i + 1, int.parse(split[2])), 1]);
            }
          }
        }

        // NUMBER + LIBRO + CHAPTER + VERSE
        else if(split.length == 4 && split[0].isNum && split[1].isAlphabetOnly && split[2].isNum && split[3].isNum){
          for(int i = 0; i < 66; i++){
            if(removeDiacritics(intToBook[i + 1]).isCaseInsensitiveContains(removeDiacritics('${split[0]} ${split[1]}'))){
              searchList.add([i + 1, valuesOfBooksChapterAdjuster(i + 1, int.parse(split[2])), valuesOfBooksVerseAdjuster(i + 1, valuesOfBooksChapterAdjuster(i + 1, int.parse(split[2])), int.parse(split[3]))]);
            }
          }
        }
      }

      // NO CONTIENE ESPACIOS
      else{
        for(int i = 0; i < 66; i++){
          if(removeDiacritics(intToBook[i + 1]).isCaseInsensitiveContains(removeDiacritics(clearText))){
            searchList.add([i + 1, 1, 1]);
          }
        }
      }

    }

    update();
  }

  void clearSearchTextField(){
    textEditingController.text = '';
    searchList.clear();
    update();
  }

  void searchListItemOnTap(int index){
    BiblePageController biblePageController = Get.find();
    biblePageController.autoScrollController.jumpTo(0);
    biblePageController.setReference(searchList[index][0], searchList[index][1], searchList[index][2]);
    Get.back();
    Get.back();
  }

}