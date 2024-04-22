import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/service/models/place_result.dart';
import 'package:recommendo/common/geo_location/geo_location_service.dart';
import 'package:recommendo/common/localized_error_text.dart';

part 'search_state.dart';
part 'search_cubit.g.dart';

class SearchCubit extends HydratedCubit<SearchState> {
  SearchCubit(this._geoLocationService) : super(const SearchState());

  final GeoLocationService _geoLocationService;

  void updateTerm(String term) {
    emit(SearchState(cityResult: state.cityResult, term: term));
  }

  void updateCity(PlaceResult? city) {
    emit(SearchState(cityResult: city, term: state.term));
  }

  Future<void> getCityByGeoLocation() async {
    final previousCity = state.cityResult;
    emit(
      SearchState(
        term: state.term,
        loadingGeoLocatoin: true,
      ),
    );

    final appResponse = await _geoLocationService.getCurrentCity();
    if (appResponse.result != null) {
      return emit(
        SearchState(
          cityResult: appResponse.result,
          term: state.term,
        ),
      );
    }
    return emit(
      SearchState(
        cityResult: previousCity,
        term: state.term,
        errorCode: appResponse.error?.code,
      ),
    );
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
