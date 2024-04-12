import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/bloc/search_field_event.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/bloc/search_field_state.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_item.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_repository.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/search_result_error.dart';
import 'package:stream_transform/stream_transform.dart';

const _duration = Duration(milliseconds: 400);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchFieldBloc extends Bloc<SearchFieldEvent, SearchFieldState> {
  SearchFieldBloc({
    required FormFieldState<BaseSearchItem?> formField,
    required BaseSearchRepository repository,
  })  : _formField = formField,
        _repository = repository,
        super(SearchStateEmpty()) {
    textController.text = _formField.value?.preview ?? '';
    on<TextChanged>(_onTextChanged, transformer: debounce(_duration));
    on<ItemSelected>(_onItemSelected);
    on<ClearTapped>(_onClearTapped);
    on<TapppedOutside>(_onTapOutside);
  }

  final FormFieldState<BaseSearchItem?> _formField;
  final BaseSearchRepository _repository;
  final textController = TextEditingController();
  final overlayController = OverlayPortalController();

  Future<void> _onTextChanged(
    TextChanged event,
    Emitter<SearchFieldState> emit,
  ) async {
    final searchTerm = textController.text;

    if (searchTerm.isEmpty) return emit(SearchStateEmpty());

    overlayController.show();
    emit(SearchStateLoading());
    try {
      final results = await _repository.search(searchTerm);

      emit(SearchStateSuccess(results.items));
    } catch (error) {
      emit(
        error is SearchResultError
            ? SearchStateError(error.message)
            : const SearchStateError('something went wrong'),
      );
    }
  }

  void _onItemSelected(ItemSelected event, Emitter<SearchFieldState> emit) {
    _formField
      ..didChange(event.item)
      ..save();
    textController.text = event.item.preview;
    overlayController.hide();
    emit(SearchStateEmpty());
  }

  void _onClearTapped(ClearTapped event, Emitter<SearchFieldState> emit) {
    _formField
      ..didChange(null)
      ..save();
    textController.clear();
    overlayController.hide();
    emit(SearchStateEmpty());
  }

  void _onTapOutside(TapppedOutside event, Emitter<SearchFieldState> emit) {
    _formField.save();
    textController.text = _formField.value?.preview ?? '';
    overlayController.hide();
    emit(SearchStateEmpty());
  }
}