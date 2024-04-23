import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:recommendo/app/auth/service/app_auth_controller.dart';
import 'package:recommendo/app/auth/service/impl/firebase_auth_service.dart';
import 'package:recommendo/app/recommendo/data/entity/recommendation_local.dart';
import 'package:recommendo/app/recommendo/data/local/recommendations_local.dart';
import 'package:recommendo/app/recommendo/data/recommendations_repository_impl.dart';
import 'package:recommendo/app/recommendo/data/remote/recommendations_remote.dart';
import 'package:recommendo/app/recommendo/service/recommendations_service.dart';
import 'package:recommendo/app/recommendo/service/repository/recommendations_repository.dart';
import 'package:recommendo/app/recommendo/view/bloc/creating_page_blocs/create_recommendation_cubit.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/entity/local_place_result.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/google_maps_api_repository.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/local/google_auto_completion_last_selected.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/remote/google_maps_api_remote.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/service/google_autocompletion_service.dart';
import 'package:recommendo/common/geo_location/geo_location_service.dart';
import 'package:recommendo/common/geo_location/native/platform_geo_location.g.dart';
import 'package:recommendo/common/token_interceptor.dart';
import 'package:uuid/uuid.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  final appAuth = AppAuthController(FirebaseAuthService());
  await appAuth.initAuth();
  getIt.registerSingleton(appAuth);

  await _initHive();

  await _initRecommendoServices();

  await _initGoogleServices();

  await getIt.allReady();
}

Future<void> _initHive() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(LocalPlaceResultAdapter())
    ..registerAdapter(RecommendationLocalModelAdapter());
}

Future<void> _initRecommendoServices() async {
  const backendBaseUrl = String.fromEnvironment('BACKEND_BASE_URL');
  final options = BaseOptions(
    // ignore: avoid_redundant_argument_values
    baseUrl: backendBaseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 10),
  );

  final dio = Dio(options);
  dio.interceptors.add(TokenInterceptor(getIt()));
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      compact: false,
    ),
  );

  final recommendationsBox =
      await Hive.openBox<RecommendationLocalModel>('recommendationsLocalBox');

  getIt
    ..registerSingleton(
      RecommendationsLocal(recommendationsBox),
    )
    ..registerSingleton(RecommendationsRemote(dio))
    ..registerSingleton<RecommendationsRepository>(
      RecommendationsRepositoryImpl(getIt(), getIt()),
    )
    ..registerSingleton(RecommendationService(getIt()))
    ..registerSingleton(CreateRecommendationCubit(getIt()));
}

Future<void> _initGoogleServices() async {
  final cacheOptions = CacheOptions(
    store: MemCacheStore(),
    policy: CachePolicy.forceCache,
    hitCacheOnErrorExcept: const [],
    maxStale: const Duration(minutes: 1),
  );

  const apiKey = String.fromEnvironment('MAPS_API_KEY');
  final sessionToken = const Uuid().v4();
  final options = BaseOptions(
    baseUrl: 'https://maps.googleapis.com',
    connectTimeout: const Duration(seconds: 1),
    receiveTimeout: const Duration(seconds: 1),
    queryParameters: {
      'key': apiKey,
      'sessiontoken': sessionToken,
      'language': Platform.localeName,
    },
  );

  final client = Dio(options);
  client.interceptors.add(
    DioCacheInterceptor(options: cacheOptions),
  );
  client.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      compact: false,
    ),
  );
  final remote = GoogleMapsApiRemote(client);

  final cityBox = await Hive.openBox<LocalPlaceResult>('cityBox');
  final establishmentBox =
      await Hive.openBox<LocalPlaceResult>('establishmentBox');

  getIt
    ..registerSingleton(GoogleMapsApiRepository(remote))
    ..registerSingleton(
      GoogleAutocompletionService(
        getIt(),
        'locality',
        GoogleAutoCompletionLastSelected(cityBox),
      ),
      instanceName: autoCompleteCity,
    )
    ..registerSingleton(
      GoogleAutocompletionService(
        getIt(),
        'establishment',
        GoogleAutoCompletionLastSelected(establishmentBox),
      ),
      instanceName: autoCompleteEstablishment,
    )
    ..registerSingleton(
      GeoLocationService(
        PlatformGeoLocation(),
        getIt(),
        'locality',
      ),
    );
}
