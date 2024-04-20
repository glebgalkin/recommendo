// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendations_list_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendationsListState _$RecommendationsListStateFromJson(
        Map<String, dynamic> json) =>
    RecommendationsListState(
      status: $enumDecodeNullable(
              _$RecommendationsListStatusEnumMap, json['status']) ??
          RecommendationsListStatus.initial,
      recommendations: (json['recommendations'] as List<dynamic>?)
              ?.map((e) =>
                  RecommendationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      hasReachedMax: json['hasReachedMax'] as bool? ?? false,
    );

Map<String, dynamic> _$RecommendationsListStateToJson(
        RecommendationsListState instance) =>
    <String, dynamic>{
      'status': _$RecommendationsListStatusEnumMap[instance.status]!,
      'recommendations':
          RecommendationsListState._listToJson(instance.recommendations),
    };

const _$RecommendationsListStatusEnumMap = {
  RecommendationsListStatus.initial: 'initial',
  RecommendationsListStatus.success: 'success',
  RecommendationsListStatus.failure: 'failure',
  RecommendationsListStatus.invalidSearch: 'invalidSearch',
};
