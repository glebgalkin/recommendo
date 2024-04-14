part of 'recommendations_list_bloc.dart';

sealed class RecommendationsListEvent extends Equatable {
  const RecommendationsListEvent();
  @override
  List<Object> get props => [];
}

final class RecommendationsFetched extends RecommendationsListEvent {
  final CityResult? cityResult;
  final String? term;
  final bool refresh;
  const RecommendationsFetched({
    this.cityResult,
    this.term,
    this.refresh = false,
  });
}
