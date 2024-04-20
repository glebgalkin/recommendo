part of 'recommendations_list_bloc.dart';

enum RecommendationsListStatus {
  initial,
  success,
  failure,
  invalidSearch,
}

@JsonSerializable()
final class RecommendationsListState extends Equatable {
  const RecommendationsListState({
    this.status = RecommendationsListStatus.initial,
    this.recommendations = const [],
    this.hasReachedMax = false,
  });

  final RecommendationsListStatus status;
  @JsonKey(toJson: _listToJson)
  final List<RecommendationModel> recommendations;

  @JsonKey(includeToJson: false)
  final bool hasReachedMax;

  RecommendationsListState copyWith({
    RecommendationsListStatus? status,
    List<RecommendationModel>? recommendations,
    bool? hasReachedMax,
  }) {
    return RecommendationsListState(
      status: status ?? this.status,
      recommendations: recommendations ?? this.recommendations,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''RecommendationState { status: $status, hasReachedMax: $hasReachedMax, recommendations: ${recommendations.length} }''';
  }

  @override
  List<Object> get props => [status, recommendations, hasReachedMax];

  factory RecommendationsListState.fromJson(Map<String, dynamic> json) =>
      _$RecommendationsListStateFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationsListStateToJson(this);

  static List<RecommendationModel> _listToJson(
    List<RecommendationModel> list,
  ) =>
      list.take(30).toList();
}
