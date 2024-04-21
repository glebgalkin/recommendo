// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchState _$SearchStateFromJson(Map<String, dynamic> json) => SearchState(
      json['cityResult'] == null
          ? null
          : PlaceResult.fromJson(json['cityResult'] as Map<String, dynamic>),
      json['term'] as String? ?? '',
    );

Map<String, dynamic> _$SearchStateToJson(SearchState instance) =>
    <String, dynamic>{
      'cityResult': instance.cityResult,
    };
