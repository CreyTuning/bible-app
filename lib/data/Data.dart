import 'dart:convert';
import 'package:yhwh/data/Define.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:yhwh/objects/book.dart';

Data appData = Data();

class Data {
  int _bookNumber = 1;
  int _chapterNumber = 1;
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
}