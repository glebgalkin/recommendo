import 'package:json_annotation/json_annotation.dart';

part 'recommended_place_feed_response.g.dart';

@JsonSerializable()
class RecommendedPlaceFeedResponse {
  final String id;
  final String title;
  final String description;
  final String img;
  final List<DataSource> sources;
  final int recommendedCount;

  const RecommendedPlaceFeedResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.img,
    required this.sources,
    required this.recommendedCount,
  });

  factory RecommendedPlaceFeedResponse.fromJson(Map<String, dynamic> json) =>
      _$RecommendedPlaceFeedResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendedPlaceFeedResponseToJson(this);
}

@JsonSerializable()
class DataSource {
  final String id;
  final String type;

  const DataSource({
    required this.id,
    required this.type,
  });
  factory DataSource.fromJson(Map<String, dynamic> json) =>
      _$DataSourceFromJson(json);

  Map<String, dynamic> toJson() => _$DataSourceToJson(this);
}
