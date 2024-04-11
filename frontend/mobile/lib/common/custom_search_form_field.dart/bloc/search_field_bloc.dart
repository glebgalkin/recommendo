import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/bloc/search_field_event.dart';
import 'package:recommendo/common/custom_search_form_field.dart/bloc/search_field_state.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/base_search_repository.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/base_search_result_error.dart';
import 'package:stream_transform/stream_transform.dart';

const _duration = Duration(milliseconds: 100);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchFieldBloc extends Bloc<SearchFieldEvent, SearchFieldState> {
  SearchFieldBloc({required this.repository}) : super(SearchStateEmpty()) {
    on<TextChanged>(_onTextChanged, transformer: debounce(_duration));
  }

  final BaseSearchRepository repository;

  Future<void> _onTextChanged(
    TextChanged event,
    Emitter<SearchFieldState> emit,
  ) async {
    final searchTerm = event.text;

    if (searchTerm.isEmpty) return emit(SearchStateEmpty());

    emit(SearchStateLoading());

    try {
      final results = await repository.search(searchTerm);
      emit(SearchStateSuccess(results.items));
    } catch (error) {
      emit(
        error is BaseSearchResultError
            ? SearchStateError(error.message)
            : const SearchStateError('something went wrong'),
      );
    }
  }
}
