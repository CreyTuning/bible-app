import 'package:flutter/animation.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yhwh/classes/AppTheme.dart';
import 'package:yhwh/controllers/BiblePageController.dart';

class ReadPreferencesController extends GetxController{

  BiblePageController _biblePageController = Get.find();
  GetStorage getStorage = GetStorage();

  void setTheme(String themeName) {
    getStorage.write('currentTheme', themeName);
    Get.changeTheme(AppTheme.getTheme(themeName));
    Get.back();
  }

  void onFontSizeUpdate(double fontSize) {
    _biblePageController.fontSize = fontSize;
    _biblePageController.update();
  }

  void onFontSizeChangeEnd(double _fontSize) {
    
    for (var verseRaw in _biblePageController.versesRawList) {
      verseRaw.fontSize = _fontSize;
    }

    _biblePageController.update();
    getStorage.write("fontSize", _fontSize);
  }

  void onFontHeightUpdate(double _fontHeight) {
    _biblePageController.fontHeight = _fontHeight;
    _biblePageController.update();
  }

  void onFontHeightChangeEnd(double _fontHeight) {
    
    for (var verseRaw in _biblePageController.versesRawList) {
      verseRaw.fontHeight = _fontHeight;      
    }

    _biblePageController.update();
    getStorage.write("fontHeight", _fontHeight);
  }

  void onFontLetterSeparationUpdate(double _fontLetterSeparation) {
    _biblePageController.fontLetterSeparation = _fontLetterSeparation;
    _biblePageController.update();
  }

  void onFontLetterSeparationChangeEnd(double _fontLetterSeparation) {
    
    for (var verseRaw in _biblePageController.versesRawList) {
      verseRaw.fontLetterSeparation = _fontLetterSeparation;      
    }

    _biblePageController.update();
    getStorage.write("fontLetterSeparation", _fontLetterSeparation);
  }

  void restoreSettingOnTap(){
    _biblePageController.fontSize = 20.0;
    _biblePageController.fontHeight = 1.8;
    _biblePageController.fontLetterSeparation = 0.0;

    for (var verseRaw in _biblePageController.versesRawList) {
      verseRaw.fontSize = _biblePageController.fontSize;
      verseRaw.fontHeight = _biblePageController.fontHeight;
      verseRaw.fontLetterSeparation = _biblePageController.fontLetterSeparation;
    }

    _biblePageController.update();

    getStorage.write("fontSize", _biblePageController.fontSize);
    getStorage.write("fontHeight", _biblePageController.fontHeight);
    getStorage.write("fontLetterSeparation", _biblePageController.fontLetterSeparation);
  }
}