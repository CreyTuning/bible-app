import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:yhwh/data/Define.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:yhwh/objects/book.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Data appData = Data();

class Data {
  bool darkMode = false;
  int _bookNumber = 1;
  int _chapterNumber = 1;

  String fontFamily = 'Roboto';
  double fontSize = 20.0;
  double fontHeight  = 1.8;
  double fontLetterSpacing = 0;

  double scrollOffset = 0;
  int bottomNavigationBarIndex = 0;

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


  Future<void> saveData() async
  {
    Directory dir = await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/savedata.json');

    Map data = {
      'darkMode' : darkMode,
      '_bookNumber' : _bookNumber,
      '_chapterNumber' : _chapterNumber,
      'fontFamily' : fontFamily,
      'fontSize' : fontSize,
      'fontHeight'  : fontHeight,
      'fontLetterSpacing' : fontLetterSpacing,
      "scrollOffset" : scrollOffset,
      'bottomNavigationBarIndex' : bottomNavigationBarIndex
    };

    file.writeAsStringSync(jsonEncode(data));
  }

  Future<bool> loadSaveData() async
  {
    Directory dir = await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/savedata.json');

    if(await file.exists()){
      Map data = await json.decode(file.readAsStringSync());

      darkMode = data['darkMode'];
      _bookNumber = data['_bookNumber'];
      _chapterNumber = data['_chapterNumber'];
      fontFamily = data['fontFamily'];
      fontSize = data['fontSize'];
      fontHeight = data['fontHeight'];
      fontLetterSpacing = data['fontLetterSpacing'];
      scrollOffset = data['scrollOffset'];
      bottomNavigationBarIndex = data['bottomNavigationBarIndex'];
    }

    else{
      await saveData();
      print('file not exist');
    }

    return true;
  }

  Future<void> loadBook(int number) async
  {
    _bookMap = await json.decode(await rootBundle.loadString(intToBookPath[number]));
    await _book.fromMap(_bookMap);

    _bookNumber = number;
  }

  Future<void> init() async
  {
    await loadSaveData();
    _bookMap = await json.decode(await rootBundle.loadString(intToBookPath[_bookNumber]));
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

    saveData();
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

    saveData();
  }

  Future<void> setChapter(int chapter) async
  {
    _chapterNumber = chapter;
    await saveData();
  }

  get darkModeEnabled{
    return darkMode;
  }

  set setDarkMode(bool state){
    this.darkMode = state;
    saveData();
  }


  void fontIncrement()
  {
    if(fontSize < 50)
      fontSize += 1;

    saveData();
  }

  void fontDecrement()
  {
    if(fontSize > 16)
      fontSize -= 1;

    saveData();
  }

  void fontLineSpaceIncrement()
  {
    if(fontHeight < 3)
      fontHeight += 0.2;

    saveData();
  }

  void fontLineSpaceDecrement()
  {
    if(fontHeight > 1.2)
      fontHeight -= 0.2;

    saveData();
  }

  void fontLetterSpaceIncrement()
  {
    if(fontLetterSpacing < 10)
      fontLetterSpacing += 0.25;

    saveData();
  }

  void fontLetterSpaceDecrement()
  {
    if(fontLetterSpacing > -1)
      fontLetterSpacing -= 0.25;

    saveData();
  }

}




class appTheme
{
  final theme_light = ThemeData(
    primaryColor: Colors.green,
    fontFamily: 'Roboto',
    accentColor: Colors.green,
    buttonColor: Color(0xffffffff),
    backgroundColor: Color(0xffffffff),
    canvasColor: Colors.white,
    brightness: Brightness.light,

    iconTheme: IconThemeData(
        color: Color(0xff263238),
    ),

    buttonTheme: ButtonThemeData(
      buttonColor: Colors.white,
    ),

    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.green,
      focusColor: Colors.green,
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.green
        )
      )

    ),


    tabBarTheme: TabBarTheme(
      labelColor: Color(0xff263238),
      labelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      unselectedLabelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Colors.green, width: 3.0),
      )
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
    primaryColor: Colors.green,
    accentColorBrightness: Brightness.dark,
    fontFamily: 'Roboto',
    accentColor: Colors.green,
    buttonColor: Color(0xff202124),
    backgroundColor: Color(0xff202124),
    canvasColor: Color(0xff202124),
    brightness: Brightness.dark,


    iconTheme: IconThemeData(
        color: Color(0xfff0f2f3)
    ),

    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xff202124),
    ),

    tabBarTheme: TabBarTheme(
      labelColor: Color(0xfff0f2f3),
      labelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      unselectedLabelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
    ),

    textTheme: TextTheme(
        button: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xfff0f2f3)),
        body2: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xfff0f2f3)),
        body1: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff9aa0a6))

    ),

    appBarTheme: AppBarTheme(
        color: Color(0xff202124),
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Color(0xfff0f2f3)),

        textTheme: TextTheme(
            title: TextStyle(fontSize: 20,fontFamily: 'Roboto', color: Color(0xfff0f2f3), fontWeight: FontWeight.bold),
            button: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xfff0f2f3))
        )
    )
  );
}