import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/service/model/recommendation_model.dart';
import 'package:recommendo/app/recommendo/service/recommendations_service.dart';
import 'package:stream_transform/stream_transform.dart';

part 'list_view_state.dart';
part 'list_view_event.dart';

const throttleDuration = Duration(milliseconds: 100);

class ListViewCubit extends Bloc<ListViewEvent, ListViewState> {
  final RecommendationService _service;

  ListViewCubit(this._service) : super(initialState) {
    on<LoadMoreEvent>(
      _loadMore,
      transformer: (events, mapper) =>
          events.debounce(throttleDuration).switchMap(mapper),
    );
  }

  Future<void> _loadMore(
    LoadMoreEvent event,
    Emitter<ListViewState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final result = await _service.getRecommendations(
      offset: state.values.length,
    );
    if (result.error != null) {
      emit(
        state.copyWith(
          error: result.error!.msg,
          isLoading: false,
        ),
      );
    } else {
      final list = result.result!;
      if (list.isEmpty) {
        emit(state.copyWith(hasReachedMax: true));
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            values: List.of(state.values)..addAll(list),
            hasReachedMax: false,
          ),
        );
      }
    }
  }
}
