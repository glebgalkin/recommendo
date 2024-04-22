import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:recommendo/common/app_response.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/google_auto_complete_error.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/google_maps_api_repository.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/service/models/place_result.dart';
import 'package:recommendo/common/geo_location/native/platform_geo_location.g.dart';
import 'package:recommendo/common/localized_error_text.dart';

class GeoLocationService {
  final PlatformGeoLocation _platformRepo;
  final GoogleMapsApiRepository _mapsApi;
  final String type;

  const GeoLocationService(this._platformRepo, this._mapsApi, this.type);

  Future<AppResponse<PlaceResult?>> getCurrentCity() async {
    try {
      final coords = await _platformRepo.getCoordinates();
      final place = await _mapsApi.reverseGeocoding(
        '${coords.lat},${coords.lng}',
        type,
      );
      if (place != null) {
        final value = PlaceResult(
          preview: place.formattedAddress,
          value: place.placeId,
        );
        return AppResponse.success(value);
      }
      return const AppResponse.error(
        Failure(code: LocalizedErrorMessage.geoLocationNotFound),
      );
    } on PlatformException catch (e) {
      return AppResponse.error(
        Failure(
          exception: e,
          code: LocalizedErrorMessage.geoLocationPermissionsNotGranted,
        ),
      );
    } on GoogleMapsApiError catch (e) {
      return AppResponse.error(
        Failure(
          exception: e,
          code: LocalizedErrorMessage.geoLocationGoogleMapsApiError,
        ),
      );
    } on DioException catch (e) {
      return AppResponse.error(
        Failure(exception: e, code: LocalizedErrorMessage.defaultNetworkError),
      );
    } on Exception catch (e) {
      return AppResponse.error(
        Failure(exception: e, code: LocalizedErrorMessage.unknown),
      );
    }
  }
}
