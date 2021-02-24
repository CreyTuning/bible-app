// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'highlighterItem.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HighlighterItemAdapter extends TypeAdapter<HighlighterItem> {
  @override
  final int typeId = 1;

  @override
  HighlighterItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HighlighterItem(
      book: fields[0] as int,
      chapter: fields[1] as int,
      verses: (fields[2] as List)?.cast<int>(),
      color: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HighlighterItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.book)
      ..writeByte(1)
      ..write(obj.chapter)
      ..writeByte(2)
      ..write(obj.verses)
      ..writeByte(3)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HighlighterItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
