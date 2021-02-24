import 'package:hive/hive.dart';

part 'highlighterItem.g.dart';

@HiveType(typeId: 1) class HighlighterItem {
  @HiveField(0) int book;
  @HiveField(1) int chapter;
  @HiveField(2) List<int> verses;
  @HiveField(3) String color;

  HighlighterItem({this.book, this.chapter, this.verses, this.color});

  @override
  String toString() {
    return '$book $chapter:$verses - $color';
  }
}