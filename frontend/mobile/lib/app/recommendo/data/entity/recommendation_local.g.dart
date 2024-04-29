// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecommendationLocalModelAdapter
    extends TypeAdapter<RecommendationLocalModel> {
  @override
  final int typeId = 0;

  @override
  RecommendationLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecommendationLocalModel(
      id: fields[0] as String,
      cityId: fields[1] as String,
      cityName: fields[2] as String,
      title: fields[3] as String,
      description: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RecommendationLocalModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.cityId)
      ..writeByte(2)
      ..write(obj.cityName)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecommendationLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
