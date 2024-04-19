// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_place_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalPlaceResultAdapter extends TypeAdapter<LocalPlaceResult> {
  @override
  final int typeId = 1;

  @override
  LocalPlaceResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalPlaceResult(
      preview: fields[0] as String,
      value: fields[1] as String,
      timeSelected: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, LocalPlaceResult obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.preview)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.timeSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalPlaceResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
