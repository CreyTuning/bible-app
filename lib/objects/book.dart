import 'package:flutter/cupertino.dart';
import 'package:yhwh/objects/chapter.dart';

class Book {
  String title = 'title';
  String description = 'description';
  String abbreviation = 'abbreviation';
  BuildContext context;

  List<Chapter> chapters = List<Chapter>();

  Book({this.title, this.description, this.chapters, this.context});


  Future<void> fromMap(Map map) async
  {
    chapters = List<Chapter>();

    this.title = map['title'];
    this.description = map['description'];
    this.abbreviation = map['abbreviation'];

    for (int i = 0; i < map['chapters'].length; i++) {
      Chapter tempChapter = Chapter();
      await tempChapter.fromMap(map['chapters'][i]);

      chapters.add(tempChapter);
    }
  }
}