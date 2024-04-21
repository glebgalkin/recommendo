part of 'recommendations_list_bloc.dart';

enum RecommendationsListStatus {
  loading,
  success,
  failure,
  invalidSearch,
}

final class RecommendationsListState extends Equatable {
  const RecommendationsListState({
    required this.status,
    this.recommendations = const [],
    this.hasReachedMax = false,
  });

  final RecommendationsListStatus status;
  final List<RecommendationModel> recommendations;
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
}
