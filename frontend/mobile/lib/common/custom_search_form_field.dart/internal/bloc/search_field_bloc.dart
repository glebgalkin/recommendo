import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_item.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_repository.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_result.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/search_result_error.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_field_event.dart';
part 'search_field_state.dart';

const _duration = Duration(milliseconds: 400);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchFieldBloc extends Bloc<SearchFieldEvent, SearchFieldState> {
  SearchFieldBloc(this._repository, BaseSearchItem? initialValue)
      : super(SearchFieldInitial(value: initialValue)) {
    on<TextChanged>(_onTextChanged, transformer: debounce(_duration));
    on<TapppedOutside>(_onTapOutside);
    on<ClearTapped>(_onClearTapped);
    on<ItemSelected>(_onItemSelected);
    on<SearchStarted>(_onSearchStarted);
  }

  final BaseSearchRepository _repository;

  Future<void> _onTextChanged(
    TextChanged event,
    Emitter<SearchFieldState> emit,
  ) async {
    final searchTerm = event.text;
    if (searchTerm.isEmpty) {
      final result = _repository.previousSearchResult();
      return emit(
        SearchStateSuccess(
          searchList: result.items,
          previousList: true,
          value: state.value,
        ),
      );
    }

    emit(SearchStateLoading(value: state.value));
    try {
      late final BaseSearchResult result;
      if (!event.offlineSearch) {
        result = await _repository.search(searchTerm);
      } else {
        result = _repository.offlineSearch(searchTerm);
      }
      emit(SearchStateSuccess(searchList: result.items));
    } on SearchResultError catch (exception) {
      emit(SearchStateError(error: exception, value: state.value));
    }
  }

  void _onTapOutside(TapppedOutside event, Emitter<SearchFieldState> emit) {
    emit(SearchFieldInitial(value: state.value));
  }

  void _onClearTapped(ClearTapped event, Emitter<SearchFieldState> emit) {
    emit(const SearchFieldInitial());
  }

  void _onItemSelected(ItemSelected event, Emitter<SearchFieldState> emit) {
    _repository.saveSelected(event.item);
    emit(SearchFieldInitial(value: event.item));
  }

  void _onSearchStarted(SearchStarted event, Emitter<SearchFieldState> emit) {
    final result = _repository.previousSearchResult();
    emit(
      SearchStateSuccess(
        searchList: result.items,
        previousList: true,
        value: state.value,
      ),
    );
  }
}
