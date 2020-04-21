import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:yhwh/data/Define.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:yhwh/objects/book.dart';
import 'package:flutter/material.dart';

Data appData = Data();

class Data {
  bool darkMode = false;
  int _bookNumber = 1;
  int _chapterNumber = 1;

  String fontFamily = 'Roboto';
  double fontSize = 20.0;
  double fontHeight  = 1.8;
  double fontLetterSpacing = 0;

  Book _book = Book();
  Map _bookMap = Map();
  List namesAndChapters = const [
    ["Génesis", 50],
    ["Éxodo", 40],
    ["Levítico", 27],
    ["Números", 36],
    ["Deuteronomio", 34],
    ["Josué", 24],
    ["Jueces", 21],
    ["Rut", 4],
    ["1 Samuel", 31],
    ["2 Samuel", 24],
    ["1 Reyes", 22],
    ["2 Reyes", 25],
    ["1 Crónicas", 29],
    ["2 Crónicas", 36],
    ["Esdras", 10],
    ["Nehemías", 13],
    ["Ester", 10],
    ["Job", 42],
    ["Salmos", 150],
    ["Proverbios", 31],
    ["Eclesiastés", 12],
    ["Cantares", 8],
    ["Isaías", 66],
    ["Jeremías", 52],
    ["Lamentaciones", 5],
    ["Ezequiel", 48],
    ["Daniel", 12],
    ["Oseas", 14],
    ["Joel", 3],
    ["Amós", 9],
    ["Abdías", 1],
    ["Jonás", 4],
    ["Miqueas", 7],
    ["Nahum", 3],
    ["Habacuc", 3],
    ["Sofonías", 3],
    ["Haggeo", 2],
    ["Zacarías", 14],
    ["Malaquías", 4],
    ["Mateo", 18],
    ["Marcos", 16],
    ["Lucas", 24],
    ["Juan", 21],
    ["Actos", 28],
    ["Romanos", 16],
    ["1 Corintios", 16],
    ["2 Corintios", 13],
    ["Gálatas", 6],
    ["Efesios", 6],
    ["Filipenses", 4],
    ["Colosenses", 4],
    ["1 Tesalonicenses", 5],
    ["2 Tesalonicenses", 3],
    ["1 Timoteo", 6],
    ["2 Timoteo", 4],
    ["Tito", 3],
    ["Filemón", 1],
    ["Hebreos", 13],
    ["Jacobo", 5],
    ["1 Pedro", 5],
    ["2 Pedro", 3],
    ["1 Juan", 5],
    ["2 Juan", 1],
    ["3 Juan", 1],
    ["Judas", 1],
    ["Revelación", 22]
  ];


  Future<void> loadBook(int number) async
  {
    _bookMap = await json.decode(await rootBundle.loadString(intToBookPath[number]));
    await _book.fromMap(_bookMap);

    _bookNumber = number;
  }

  Future<void> init() async
  {
    _bookMap =
    await json.decode(await rootBundle.loadString(intToBookPath[_bookNumber]));
    await _book.fromMap(_bookMap);
  }

  Data() {
    init();
  }


  Future<Book> get getBook async {
    await init();
    return _book;
  }

  String get getTitle => _book.title;
  String get getDescription => _book.description;
  int get getBookNumber => _bookNumber;
  int get getChapterNumber => _chapterNumber;


  Future<void> nextChapter() async
  {
    if (_chapterNumber < _book.chapters.length) {
      _chapterNumber++;
    }

    else if (_chapterNumber == _book.chapters.length) {
      if (_bookNumber < 66) {
        await loadBook(_bookNumber + 1);
        _chapterNumber = 1;
      }
    }
  }

  Future<void> previousChapter() async{
    if (_chapterNumber > 1) {
      _chapterNumber--;
    }

    else if (_chapterNumber == 1)
    {
      if(_bookNumber > 1)
      {
        await loadBook(_bookNumber - 1);
        _chapterNumber = _book.chapters.length;
      }
    }
  }

  Future<void> setChapter(int chapter) async
  {
    _chapterNumber = chapter;
  }

  get darkModeEnabled{
    return darkMode;
  }

  set setDarkMode(bool state){
    this.darkMode = state;
  }


  void fontIncrement()
  {
    fontSize += 1;
  }

  void fontDecrement()
  {
    if(fontSize > 16)
      fontSize -= 1;
  }

  void fontLineSpaceIncrement()
  {
    if(fontHeight < 2.6)
      fontHeight += 0.2;
  }

  void fontLineSpaceDecrement()
  {
    if(fontHeight > 1.4)
      fontHeight -= 0.2;
  }

  void fontLetterSpaceIncrement()
  {
    if(fontLetterSpacing < 3)
      fontLetterSpacing += 0.25;
  }

  void fontLetterSpaceDecrement()
  {
    if(fontLetterSpacing > -1)
      fontLetterSpacing -= 0.25;
  }

}





class appTheme
{
  final theme_light = ThemeData(
      fontFamily: 'Roboto',
      accentColor: Colors.green,
      accentColorBrightness: Brightness.light,
      buttonColor: Color(0xffffffff),
      backgroundColor: Color(0xffffffff),
      canvasColor: Colors.white,
      brightness: Brightness.light,

      iconTheme: IconThemeData(
          color: Color(0xff263238),
          opacity: 20.0
      ),

      buttonTheme: ButtonThemeData(
        buttonColor: Colors.white,


      ),

      tabBarTheme: TabBarTheme(
        labelColor: Color(0xff263238),
        labelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
        unselectedLabelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      ),

      textTheme: TextTheme(
          button: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff263238)),
          body2: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff263238)),
          body1: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xaf37474F))

      ),

      appBarTheme: AppBarTheme(
          color: Colors.white,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Color(0xff263238)),

          textTheme: TextTheme(
              title: TextStyle(fontSize: 20,fontFamily: 'Roboto', color: Color(0xff263238), fontWeight: FontWeight.bold),
              button: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff263238))
          )
      )
  );


  final theme_dark = ThemeData(
      accentColorBrightness: Brightness.dark,
      fontFamily: 'Roboto',
      accentColor: Colors.green,
      buttonColor: Color(0xff21242b),
      backgroundColor: Color(0xff21242b),
      canvasColor: Color(0xff21242b),
      brightness: Brightness.dark,



      iconTheme: IconThemeData(
          color: Color(0xffb0b6c2)
      ),

      buttonTheme: ButtonThemeData(
        buttonColor: Color(0xff21242b),
      ),

      tabBarTheme: TabBarTheme(
        labelColor: Color(0xffb0b6c2),
        labelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
        unselectedLabelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      ),

      textTheme: TextTheme(
          button: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xffb0b6c2)),
          body2: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xffb0b6c2)),
          body1: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff636b76))

      ),

      appBarTheme: AppBarTheme(
          color: Color(0xff21242b),
          brightness: Brightness.dark,
          iconTheme: IconThemeData(color: Color(0xffb0b6c2)),

          textTheme: TextTheme(
              title: TextStyle(fontSize: 20,fontFamily: 'Roboto', color: Color(0xffb0b6c2), fontWeight: FontWeight.bold),
              button: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xffb0b6c2))
          )
      )
  );
}