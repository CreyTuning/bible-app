import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:yhwh/data/Define.dart';
part 'highlighterItem.g.dart';

@HiveType(typeId: 1) class HighlighterItem {
  
  @HiveField(0) String id;
  @HiveField(1) int color;
  @HiveField(2) int book;
  @HiveField(3) int chapter;
  @HiveField(4) List<int> verses;

  HighlighterItem({@required this.id, @required this.book, @required this.chapter, @required this.verses, @required this.color});

  @override
  String toString() {
    return '[$id] ${intToBook[book]} $chapter:$verses - ${color.toRadixString(16)}';
  }
}