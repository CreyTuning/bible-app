import 'package:hive/hive.dart';
import 'package:yhwh/data/Define.dart';

part 'highlighterOrderItem.g.dart';

@HiveType(typeId: 2) class HighlighterOrderItem {
  
  @HiveField(0) String id;
  @HiveField(1) int book;
  @HiveField(2) int chapter;

  HighlighterOrderItem({required this.id, required this.book, required this.chapter});

  @override
  String toString() {
    return '[$id] ${intToBook[book]} $chapter';
  }
}