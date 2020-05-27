import 'dart:convert';
import 'package:yhwh/data/Define.dart';
import 'package:http/http.dart' as http;

class BibleChapter {
  BibleChapter({this.version, this.bookNumber, this.chapterNumber, this.verses});

  String version = 'kjv';
  int bookNumber = 1;
  int chapterNumber = 1;
  List<List> verses = [[1, 'hola']];


  Future<BibleChapter> getChapterFromInternet(String ver, int bNumber, int cNumber) async{

    String url = 'https://getbible.net/json?v=$ver&p=${intToBookEnglish[bNumber]}$cNumber';
    BibleChapter bibleChapter = BibleChapter();

    bibleChapter.bookNumber = bNumber;
    bibleChapter.chapterNumber = cNumber;
    bibleChapter.version = ver;
    bibleChapter.verses = await urlToVerses(url);

    return bibleChapter;
  }

  Future<List<List>> urlToVerses(String url) async {

    List<List> tempVerses = [[1, 'No hay acceso a la red']];
    http.Response response = await http.get(url);

    if(response.body != 'NULL')
    {
      tempVerses.clear();

      Map data = json.decode(response.body.substring(1, response.body.length - 2));
      
      data['chapter'].forEach((key, value) {
        tempVerses.add([value['verse_nr'], value['verse']]);
      });

      print('capitulo obtenido');
    }

    else print('no hay acceso a la red');
    
    return tempVerses;
  }
}