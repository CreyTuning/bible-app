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
      id: fields[0] as String,
      book: fields[2] as int,
      chapter: fields[3] as int,
      verses: (fields[4] as List).cast<int>(),
      color: fields[1] as int,
      dateTime: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, HighlighterItem obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.color)
      ..writeByte(2)
      ..write(obj.book)
      ..writeByte(3)
      ..write(obj.chapter)
      ..writeByte(4)
      ..write(obj.verses)
      ..writeByte(5)
      ..write(obj.dateTime);
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
