// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'done_event.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompletedEventAdapter extends TypeAdapter<CompletedEvent> {
  @override
  final int typeId = 3;

  @override
  CompletedEvent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompletedEvent(
      fields[0] as String,
      fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CompletedEvent obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompletedEventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
