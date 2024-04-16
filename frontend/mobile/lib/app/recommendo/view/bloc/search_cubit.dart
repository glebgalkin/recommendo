import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/models/city_result.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchState(null, ''));

  void updateTerm(String term) {
    emit(SearchState(state.cityResult, term));
  }

  void updateCity(CityResult? city) {
    emit(SearchState(city, state.term));
  }
}
