// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_links_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialLinksEntity _$SocialLinksEntityFromJson(Map<String, dynamic> json) =>
    SocialLinksEntity(
      instagram: json['instagram'] as String,
      facebook: json['facebook'] as String,
      telegram: json['telegram'] as String,
      webSite: json['webSite'] as String,
    );

Map<String, dynamic> _$SocialLinksEntityToJson(SocialLinksEntity instance) =>
    <String, dynamic>{
      'instagram': instance.instagram,
      'facebook': instance.facebook,
      'telegram': instance.telegram,
      'webSite': instance.webSite,
    };
