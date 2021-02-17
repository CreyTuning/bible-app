import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:yhwh/controllers/BiblePageController.dart';
import 'package:yhwh/data/Define.dart';
import 'package:diacritic/diacritic.dart';
import 'package:yhwh/data/valuesOfBooks.dart';
import 'package:get_storage/get_storage.dart';

class ReferencesPageController extends GetxController {
  PageController pageController;
  AutoScrollController bookAutoScrollController;
  AutoScrollController chapterAutoScrollController;
  AutoScrollController verseAutoScrollController;
  double buttonHeight = 60.0;
  int scrollItemDistance = 6;

  // Search view
  GetStorage getStorage = GetStorage();
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
    
    // get text from box and update search list
    textEditingController.text = getStorage.read("referencesPageSearchViewTextFieldControllerText") ?? '';
    updateSearchListFromText(textEditingController.text);
    
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

  void updateSearchListFromText(String text){
    searchList.clear();
    String clearText = text.trim();

    // El texto esta vacio
    if(text.isEmpty){
      return;
    }

    // El tecto no esta vacio
    else if(text.isNotEmpty){

      // CONTIENE ESPACIOS PERO NO ':'
      if(clearText.contains(' ') && !clearText.contains(':')){
        List<String> split = clearText.split(' ');

        // LIBRO + CHAPTER
        if(split.length == 2 && split[0].isAlphabetOnly && split[1].isNum){
          for(int i = 0; i < 66; i++){
            if(removeDiacritics(intToBook[i + 1]).isCaseInsensitiveContains(removeDiacritics(split[0])) || removeDiacritics(intToAbreviatura[i + 1]).isCaseInsensitiveContains(removeDiacritics(split[0]))){
              searchList.add([i + 1, valuesOfBooksChapterAdjuster(i + 1, int.parse(split[1])), 1]);
            }
          }
        }

        // LIBRO + CHAPTER + VERSE
        else if(split.length == 3 && split[0].isAlphabetOnly && split[1].isNum && split[2].isNum){
          for(int i = 0; i < 66; i++){
            if(removeDiacritics(intToBook[i + 1]).isCaseInsensitiveContains(removeDiacritics(split[0])) || removeDiacritics(intToAbreviatura[i + 1]).isCaseInsensitiveContains(removeDiacritics(split[0]))){
              searchList.add([i + 1, valuesOfBooksChapterAdjuster(i + 1, int.parse(split[1])), valuesOfBooksVerseAdjuster(i + 1, valuesOfBooksChapterAdjuster(i + 1, int.parse(split[1])), int.parse(split[2])) ]);
            }
          }
        }

        // LIBRO + CHAPTER + VERSE
        else if(split.length == 3 && split[0].isAlphabetOnly && split[1].isNum && split[2].isNum){
          for(int i = 0; i < 66; i++){
            if(removeDiacritics(intToBook[i + 1]).isCaseInsensitiveContains(removeDiacritics(split[0])) || removeDiacritics(intToAbreviatura[i + 1]).isCaseInsensitiveContains(removeDiacritics(split[0]))){
              searchList.add([i + 1, valuesOfBooksChapterAdjuster(i + 1, int.parse(split[1])), valuesOfBooksVerseAdjuster(i + 1, valuesOfBooksChapterAdjuster(i + 1, int.parse(split[1])), int.parse(split[2]))]);
            }
          }
        }

        // NUMBER + LIBRO
        else if(split.length == 2 && split[0].isNum && split[1].isAlphabetOnly){
          for(int i = 0; i < 66; i++){
            if(removeDiacritics(intToBook[i + 1]).isCaseInsensitiveContains(removeDiacritics('${split[0]} ${split[1]}')) || removeDiacritics(intToAbreviatura[i + 1]).isCaseInsensitiveContains(removeDiacritics('${split[0]} ${split[1]}'))){
              searchList.add([i + 1, 1, 1]);
            }
          }
        }

        // NUMBER + LIBRO + CHAPTER
        else if(split.length == 3 && split[0].isNum && split[1].isAlphabetOnly && split[2].isNum){
          for(int i = 0; i < 66; i++){
            if(removeDiacritics(intToBook[i + 1]).isCaseInsensitiveContains(removeDiacritics('${split[0]} ${split[1]}')) || removeDiacritics(intToAbreviatura[i + 1]).isCaseInsensitiveContains(removeDiacritics('${split[0]} ${split[1]}'))){
              searchList.add([i + 1, valuesOfBooksChapterAdjuster(i + 1, int.parse(split[2])), 1]);
            }
          }
        }

        // NUMBER + LIBRO + CHAPTER + VERSE
        else if(split.length == 4 && split[0].isNum && split[1].isAlphabetOnly && split[2].isNum && split[3].isNum){
          for(int i = 0; i < 66; i++){
            if(removeDiacritics(intToBook[i + 1]).isCaseInsensitiveContains(removeDiacritics('${split[0]} ${split[1]}')) || removeDiacritics(intToAbreviatura[i + 1]).isCaseInsensitiveContains(removeDiacritics('${split[0]} ${split[1]}'))){
              searchList.add([i + 1, valuesOfBooksChapterAdjuster(i + 1, int.parse(split[2])), valuesOfBooksVerseAdjuster(i + 1, valuesOfBooksChapterAdjuster(i + 1, int.parse(split[2])), int.parse(split[3]))]);
            }
          }
        }
      }

      // CONTIENE ESPACIO Y ':'
      else if(clearText.contains(' ') && clearText.contains(':')){
        List<String> split = clearText.split(' ');

        // LIBRO + INPUT
        if(split.length == 2 && split[0].isAlphabetOnly && split[1].contains(':')){
          List<String> localSplit = split[1].split(':');

          // LIBRO + NUM_1 : NULL
          if(localSplit[1] == '' && localSplit[0].isNumericOnly){
            for(int i = 0; i < 66; i++){
              if(removeDiacritics(intToBook[i + 1]).isCaseInsensitiveContains(removeDiacritics(split[0])) || removeDiacritics(intToAbreviatura[i + 1]).isCaseInsensitiveContains(removeDiacritics(split[0]))){
                searchList.add([i + 1, valuesOfBooksChapterAdjuster(i + 1, int.parse(localSplit[0])), 1]);
              }
            }
          }

          // LIBRO + NUM_1 : NUM_2
          else if(localSplit[1] != '' && localSplit[1].isNumericOnly && localSplit[0].isNumericOnly){
            for(int i = 0; i < 66; i++){
              if(removeDiacritics(intToBook[i + 1]).isCaseInsensitiveContains(removeDiacritics(split[0])) || removeDiacritics(intToAbreviatura[i + 1]).isCaseInsensitiveContains(removeDiacritics(split[0]))){
                searchList.add([i + 1, valuesOfBooksChapterAdjuster(i + 1, int.parse(localSplit[0])), valuesOfBooksVerseAdjuster(i + 1, valuesOfBooksChapterAdjuster(i + 1, int.parse(localSplit[0])), int.parse(localSplit[1])) ]);
              }
            }
          }
        }

        // NUMBER + LIBRO + INPUT
        else if(split.length == 3 && split[0].isNum && split[1].isAlphabetOnly && split[2].contains(':')){
          List<String> localSplit = split[2].split(':');

          // NUMBER + LIBRO + NUM_1 : NULL
          if(localSplit[1] == '' && localSplit[0].isNumericOnly){
            for(int i = 0; i < 66; i++){
              if(removeDiacritics(intToBook[i + 1]).isCaseInsensitiveContains(removeDiacritics('${split[0]} ${split[1]}')) || removeDiacritics(intToAbreviatura[i + 1]).isCaseInsensitiveContains(removeDiacritics('${split[0]} ${split[1]}'))){
                searchList.add([i + 1, valuesOfBooksChapterAdjuster(i + 1, int.parse(localSplit[0])), 1]);
              }
            }
          }

          // NUMBER + LIBRO + NUM_1 : NUM_2
          else if(localSplit[1] != '' && localSplit[1].isNumericOnly && localSplit[0].isNumericOnly){
            for(int i = 0; i < 66; i++){
              if(removeDiacritics(intToBook[i + 1]).isCaseInsensitiveContains(removeDiacritics('${split[0]} ${split[1]}')) || removeDiacritics(intToAbreviatura[i + 1]).isCaseInsensitiveContains(removeDiacritics('${split[0]} ${split[1]}'))){
                searchList.add([i + 1, valuesOfBooksChapterAdjuster(i + 1, int.parse(localSplit[0])), valuesOfBooksVerseAdjuster(i + 1, valuesOfBooksChapterAdjuster(i + 1, int.parse(localSplit[0])), int.parse(localSplit[1])) ]);
              }
            }
          }
        }
      }

      // NO CONTIENE ESPACIOS
      else{
        for(int i = 0; i < 66; i++){
          if(removeDiacritics(intToBook[i + 1]).isCaseInsensitiveContains(removeDiacritics(clearText)) || removeDiacritics(intToAbreviatura[i + 1]).isCaseInsensitiveContains(removeDiacritics(clearText))){
            searchList.add([i + 1, 1, 1]);
          }
        }
      }
    }
  }

  void searchTextFieldOnChange(String text){
    getStorage.write('referencesPageSearchViewTextFieldControllerText', text.trim());
    searchListScrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    updateSearchListFromText(text);
    update();
  }

  void clearSearchTextField(){
    textEditingController.text = '';
    searchList.clear();
    update();

    getStorage.write('referencesPageSearchViewTextFieldControllerText', '');
  }

  void searchListItemOnTap(int index) async {
    BiblePageController biblePageController = Get.find();
    Get.back();
    Get.back();
    biblePageController.setReferenceSafeScroll(searchList[index][0], searchList[index][1], searchList[index][2]);
  }

}