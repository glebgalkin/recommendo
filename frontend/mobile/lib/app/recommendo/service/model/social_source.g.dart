// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialSource _$SocialSourceFromJson(Map<String, dynamic> json) => SocialSource(
      id: json['id'] as String,
      type: $enumDecode(_$SocialLinkTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$SocialSourceToJson(SocialSource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$SocialLinkTypeEnumMap[instance.type]!,
    };

const _$SocialLinkTypeEnumMap = {
  SocialLinkType.instagram: 'instagram',
  SocialLinkType.googleMaps: 'googleMaps',
};
