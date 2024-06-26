import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/service/model/recommended_place_model.dart';
import 'package:recommendo/app/recommendo/service/recommendations_service.dart';
import 'package:recommendo/common/google_search/service/models/place_result.dart';
import 'package:recommendo/common/localized_error_text.dart';
import 'package:stream_transform/stream_transform.dart';

part 'recommendations_list_state.dart';
part 'recommendations_list_event.dart';

const debounceDuration = Duration(milliseconds: 200);

class RecommendationsListBloc
    extends Bloc<RecommendationsListEvent, RecommendationsListState> {
  final RecommendationService _service;

  RecommendationsListBloc(
    this._service,
    RecommendationsListStatus initialStatus,
  ) : super(RecommendationsListState(status: initialStatus)) {
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
      return emit(
        const RecommendationsListState(
          status: RecommendationsListStatus.invalidSearch,
        ),
      );
    }

    if (state.hasReachedMax && !event.showLoader) return;

    if (event.showLoader) {
      emit(
        state.copyWith(status: RecommendationsListStatus.loading),
      );
    }
    final recommendations = await _service.getRecommendations(
      offset: event.showLoader ? 0 : state.recommendations.length,
      cityResult: event.cityResult!,
      term: event.term,
      searchOnDevice: event.searchOnDevice,
    );
    if (recommendations.result != null) {
      final list = recommendations.result!;
      if (list.isEmpty) {
        final resultingList = event.showLoader ? list : state.recommendations;
        return emit(
          state.copyWith(
            hasReachedMax: true,
            recommendations: resultingList,
            status: RecommendationsListStatus.success,
          ),
        );
      }
      final resultingList = event.showLoader
          ? list
          : (List.of(state.recommendations)..addAll(list));
      emit(
        state.copyWith(
          status: RecommendationsListStatus.success,
          recommendations: resultingList,
          hasReachedMax: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: RecommendationsListStatus.failure,
          errorMessage: recommendations.error!.code,
        ),
      );
    }
  }
}
