import 'dart:convert';
import 'package:yhwh/data/Define.dart';
import 'package:flutter/services.dart' show rootBundle;

Data appData = Data();

class Data
{
  int book = 1;
  int chapter = 1;
  int chaptersCount = 50;
  List<int> versesCountList = <int>[];
  List<List> librosConCapitulo = List<List>(); // [ [Genesis, 50], [Exodo, 40], []... ]

  Data()
  {
    loadData();
    getBookMap();
  }

  void loadData() async
  {
    Map<String, dynamic> bookAndChaptersDecoded = jsonDecode(await rootBundle.loadString('lib/data/books.json'));
    List<List> tempList = List<List>();

    for(List item in bookAndChaptersDecoded['books'])
      tempList.add(item);

    librosConCapitulo = tempList;
    chaptersCount = librosConCapitulo[book - 1][1];
  }

  void nextChapter()
  {
    if(chapter < chaptersCount)
    {
      chapter++;
    }

    else if (chapter == chaptersCount)
    {
      if(book < 66)
      {
        book++;
        chapter = 1;
        chaptersCount = librosConCapitulo[book - 1][1];
      }
    }
  }

  void previousChapter()
  {
    if(chapter > 1)
    {
      chapter--;
    }

    else if (chapter == 1)
    {
      if(book > 1)
      {
        book--;
        chapter = librosConCapitulo[book - 1][1];
        chaptersCount = librosConCapitulo[book - 1][1];
      }
    }
  }

  Future<Map> getBookMap() async
  {
    Map map = json.decode(await rootBundle.loadString(intToBookPath[book]));

    for(int x = 0; x < map['chapters'].length; x++)
    {
      versesCountList.add(map['chapters'][x]['verses'].length);
    }

    return map;
  }
}