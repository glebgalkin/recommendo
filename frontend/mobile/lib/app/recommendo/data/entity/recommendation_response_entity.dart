import 'package:json_annotation/json_annotation.dart';

part 'recommendation_response_entity.g.dart';

@JsonSerializable()
class RecommendationResponseEntity {
  final String id;
  final CityResponse city;
  final String title;
  final String description;
  final List<DataSource> sources;

  const RecommendationResponseEntity({
    required this.id,
    required this.city,
    required this.title,
    required this.description,
    required this.sources,
  });

  factory RecommendationResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$RecommendationResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationResponseEntityToJson(this);
}

@JsonSerializable()
class DataSource {
  final String id;
  final String type;
  final Map<String, dynamic> extra;

  const DataSource({
    required this.id,
    required this.type,
    required this.extra,
  });
  factory DataSource.fromJson(Map<String, dynamic> json) =>
      _$DataSourceFromJson(json);

  Map<String, dynamic> toJson() => _$DataSourceToJson(this);
}

@JsonSerializable()
class CityResponse {
  final String id;
  final String name;

  const CityResponse({
    required this.id,
    required this.name,
  });

  factory CityResponse.fromJson(Map<String, dynamic> json) =>
      _$CityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CityResponseToJson(this);
}
