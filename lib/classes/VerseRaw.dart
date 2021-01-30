import 'package:flutter/material.dart';

class VerseRaw {
  int verseNumber;
  
  String title;
  String text;  

  String fontFamily;
  double fontSize;
  double fontHeight;
  double fontLetterSeparation;

  Color colorText;
  Color colorNumber;
  Color colorHighlight;

  bool highlight;
  bool selected;

  VerseRaw({
    this.verseNumber,
    this.title,
    this.text,
    this.fontFamily,
    this.fontSize,
    this.fontHeight,
    this.fontLetterSeparation,
    this.colorText,
    this.colorNumber,
    this.colorHighlight,
    this.highlight,
    this.selected
  });
}