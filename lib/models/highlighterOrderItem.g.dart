// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'highlighterOrderItem.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HighlighterOrderItemAdapter extends TypeAdapter<HighlighterOrderItem> {
  @override
  final int typeId = 2;

  @override
  HighlighterOrderItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HighlighterOrderItem(
      id: fields[0] as String,
      book: fields[1] as int,
      chapter: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HighlighterOrderItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.book)
      ..writeByte(2)
      ..write(obj.chapter);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HighlighterOrderItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
