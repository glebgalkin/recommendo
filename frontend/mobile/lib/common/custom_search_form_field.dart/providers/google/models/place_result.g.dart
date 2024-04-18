// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceResultAdapter extends TypeAdapter<PlaceResult> {
  @override
  final int typeId = 0;

  @override
  PlaceResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaceResult(
      preview: fields[0] as String,
      value: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PlaceResult obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.preview)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
