// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalendereventAdapter extends TypeAdapter<Calenderevent> {
  @override
  final int typeId = 0;

  @override
  Calenderevent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Calenderevent(
      fields[0] as String,
      fields[1] as DateTime,
      fields[2] as DateTime,
      fields[3] as String,
      isDone: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Calenderevent obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.isDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalendereventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
