import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/bloc/search_field_event.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/bloc/search_field_state.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_item.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_repository.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_result_error.dart';
import 'package:stream_transform/stream_transform.dart';

const _duration = Duration(milliseconds: 100);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchFieldBloc extends Bloc<SearchFieldEvent, SearchFieldState> {
  SearchFieldBloc({required BaseSearchRepository repository})
      : _repository = repository,
        super(SearchStateEmpty()) {
    on<TextChanged>(_onTextChanged, transformer: debounce(_duration));
    on<ItemSelected>(_onItemSelected);
    on<InitField>(_onInit);
    on<ClearTapped>(_onClearTapped);
  }

  late FormFieldState<BaseSearchItem?> formField;
  final textController = TextEditingController();
  final overlayController = OverlayPortalController();
  final BaseSearchRepository _repository;

  Future<void> _onTextChanged(
    TextChanged event,
    Emitter<SearchFieldState> emit,
  ) async {
    final searchTerm = textController.text;

    if (searchTerm.isEmpty) return emit(SearchStateEmpty());

    emit(SearchStateLoading());

    try {
      final results = await _repository.search(searchTerm);

      emit(SearchStateSuccess(results.items));
      overlayController.show();
    } catch (error) {
      emit(
        error is BaseSearchResultError
            ? SearchStateError(error.message)
            : const SearchStateError('something went wrong'),
      );
    }
  }

  Future<void> _onItemSelected(
    ItemSelected event,
    Emitter<SearchFieldState> emit,
  ) async {}

  Future<void> _onInit(
    InitField event,
    Emitter<SearchFieldState> emit,
  ) async {}

  Future<void> _onClearTapped(
    ClearTapped event,
    Emitter<SearchFieldState> emit,
  ) async {}
}
