import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/service/model/recommendation_model.dart';
import 'package:recommendo/app/recommendo/service/recommendations_service.dart';

part 'list_view_state.dart';

class ListViewCubit extends Cubit<ListViewState> {
  final RecommendationService _service;

  ListViewCubit(this._service) : super(initialState);

  void clear() {
    emit(initialState);
  }

  Future<void> loadData() async {
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
