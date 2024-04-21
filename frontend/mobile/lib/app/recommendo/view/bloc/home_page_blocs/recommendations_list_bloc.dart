import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/service/model/recommendation_model.dart';
import 'package:recommendo/app/recommendo/service/recommendations_service.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/service/models/place_result.dart';
import 'package:stream_transform/stream_transform.dart';

part 'recommendations_list_state.dart';
part 'recommendations_list_event.dart';

const debounceDuration = Duration(milliseconds: 400);

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
      return emit(const RecommendationsListState());
    }

    if (state.hasReachedMax && !event.refresh) return;

    if (event.refresh) {
      emit(
        state.copyWith(status: RecommendationsListStatus.loading),
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
        return emit(
          state.copyWith(
            hasReachedMax: true,
            status: RecommendationsListStatus.success,
          ),
        );
      }
      final resultingList =
          event.refresh ? list : List.of(state.recommendations)
            ..addAll(list);
      emit(
        state.copyWith(
          status: RecommendationsListStatus.success,
          recommendations: resultingList,
          hasReachedMax: false,
        ),
      );
    } else {
      // TODO(Konyaka1): Show specific error messages
      emit(state.copyWith(status: RecommendationsListStatus.failure));
    }
  }
}
