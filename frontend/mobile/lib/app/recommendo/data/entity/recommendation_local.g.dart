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
      title: fields[3] as String,
      description: fields[4] as String,
      img: fields[5] as String,
      socialSource: (fields[6] as List).cast<SocialSourceLocal>(),
      recommendedCount: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RecommendationLocalModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.cityId)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.img)
      ..writeByte(6)
      ..write(obj.socialSource)
      ..writeByte(7)
      ..write(obj.recommendedCount);
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

class SocialSourceLocalAdapter extends TypeAdapter<SocialSourceLocal> {
  @override
  final int typeId = 2;

  @override
  SocialSourceLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SocialSourceLocal(
      id: fields[0] as String,
      type: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SocialSourceLocal obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SocialSourceLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
