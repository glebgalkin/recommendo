import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/service/models/place_result.dart';
import 'package:recommendo/common/geo_location/geo_location_service.dart';
import 'package:recommendo/service_locator/service_locator.dart';

part 'search_state.dart';
part 'search_cubit.g.dart';

class SearchCubit extends HydratedCubit<SearchState> {
  SearchCubit() : super(const SearchState(null, ''));

  void updateTerm(String term) {
    emit(SearchState(state.cityResult, term));
  }

  void updateCity(PlaceResult? city) {
    emit(SearchState(city, state.term));
  }

  Future<void> getCityByGeoLocation() async {
    final result = await getIt<GeoLocationService>().getCurrentCity();
    updateCity(result.result);
  }

  @override
  SearchState? fromJson(Map<String, dynamic> json) {
    return SearchState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SearchState state) {
    return state.toJson();
  }
}
