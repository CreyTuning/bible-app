import 'dart:convert';
import 'package:yhwh/data/Define.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:yhwh/objects/book.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Data appData = Data();

class Data {

  // Data que puede ser almacenada en Savadata
  int _bookNumber = 1;
  int _chapterNumber = 1;

  String fontFamily = 'Roboto';
  double fontSize = 20.0;
  double fontHeight  = 1.8;
  double fontLetterSpacing = 0;

  double scrollOffset = 0;
  int bottomNavigationBarIndex = 0;

  // Datos volátiles
  Book _book = Book();
  Map _bookMap = Map();
  

  String get getTitle => _book.title;
  String get getDescription => _book.description;
  int get getBookNumber => _bookNumber;
  int get getChapterNumber => _chapterNumber;


  Future<void> saveData() async
  {
    Directory dir = await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/savedata.json');

    Map data = {
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
      print('savedata ha sido creado.');
      loadSaveData();
    }

    return true;
  }

  Future<void> loadBook(int number) async
  {
    _bookMap = await json.decode(await rootBundle.loadString(intToBookPath[number]));
    await _book.fromMap(_bookMap);

    _chapterNumber = 1;
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