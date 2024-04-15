import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/service/model/recommendation_model.dart';
import 'package:recommendo/app/recommendo/service/recommendations_service.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/models/city_result.dart';
import 'package:stream_transform/stream_transform.dart';

part 'recommendations_list_state.dart';
part 'recommendations_list_event.dart';

const debounceDuration = Duration(milliseconds: 200);

class RecommendationsListBloc
    extends Bloc<RecommendationsListEvent, RecommendationsListState> {
  final RecommendationService _service;

  RecommendationsListBloc(this._service)
      : super(const RecommendationsListState()) {
    on<RecommendationsFetched>(
      _loadMore,
      transformer: (events, mapper) =>
          events.debounce(debounceDuration).switchMap(mapper),
    );
  }

  Future<void> _loadMore(
    RecommendationsFetched event,
    Emitter<RecommendationsListState> emit,
  ) async {
    if (event.cityResult == null) {
      emit(
        const RecommendationsListState(
          status: RecommendationsListStatus.invalidSearch,
        ),
      );
      return;
    }

    if (state.hasReachedMax && !event.refresh) return;
    try {
      if (event.refresh) {
        emit(
          state.copyWith(status: RecommendationsListStatus.initial),
        );
      }
      final recommendations = await _service.getRecommendations(
        offset: event.refresh ? 0 : state.recommendations.length,
        cityResult: event.cityResult!,
        term: event.term,
      );
      if (recommendations.result != null) {
        final list = recommendations.result!;
        if (list.isEmpty) {
          emit(
            state.copyWith(
              hasReachedMax: true,
              status: RecommendationsListStatus.success,
            ),
          );
          return;
        }
        if (event.refresh) {
          emit(
            state.copyWith(
              status: RecommendationsListStatus.success,
              recommendations: list,
              hasReachedMax: false,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: RecommendationsListStatus.success,
              recommendations: List.of(state.recommendations)..addAll(list),
              hasReachedMax: false,
            ),
          );
        }
      } else {
        emit(state.copyWith(status: RecommendationsListStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(status: RecommendationsListStatus.failure));
    }
  }
}
