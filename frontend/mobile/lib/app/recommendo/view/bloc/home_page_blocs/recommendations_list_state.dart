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
    this.errorMessage,
  });

  final RecommendationsListStatus status;
  final List<RecommendedPlaceModel> recommendations;
  final bool hasReachedMax;
  final LocalizedErrorMessage? errorMessage;

  RecommendationsListState copyWith({
    RecommendationsListStatus? status,
    List<RecommendedPlaceModel>? recommendations,
    bool? hasReachedMax,
    LocalizedErrorMessage? errorMessage,
  }) {
    return RecommendationsListState(
      status: status ?? this.status,
      recommendations: recommendations ?? this.recommendations,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage,
    );
  }

  @override
  String toString() {
    return '''RecommendationState { status: $status, hasReachedMax: $hasReachedMax, recommendations: ${recommendations.length}, errorCode: $errorMessage }''';
  }

  @override
  List<Object?> get props =>
      [status, recommendations, hasReachedMax, errorMessage];
}
