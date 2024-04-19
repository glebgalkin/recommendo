import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:recommendo/app/recommendo/data/entity/recommendation_response_entity.dart';
import 'package:recommendo/app/recommendo/data/local/recommendations_local.dart';
import 'package:recommendo/app/recommendo/data/recommendations_repository_impl.dart';
import 'package:recommendo/app/recommendo/data/remote/recommendations_remote.dart';
import 'package:recommendo/app/recommendo/service/recommendations_service.dart';
import 'package:recommendo/app/recommendo/service/repository/recommendations_repository.dart';
import 'package:recommendo/app/recommendo/view/bloc/creating_page_blocs/create_recommendation_cubit.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/google_auto_completion_repository.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/local/google_auto_completion_last_selected.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/models/place_result.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/remote/google_auto_completion_remote.dart';
import 'package:recommendo/common/token_interceptor.dart';
import 'package:uuid/uuid.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  final dio = _initDio();

  await _initHive();
  final recommendationsBox =
      await Hive.openBox<RecommendationResponseEntity>('recommendationsBox');

  await _initGoogleAutoCompletionRepos();

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

  await getIt.allReady();
}

Dio _initDio() {
  const backendBaseUrl = String.fromEnvironment('BACKEND_BASE_URL');
  final options = BaseOptions(
    // ignore: avoid_redundant_argument_values
    baseUrl: backendBaseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 10),
  );
  final dio = Dio(options);
  dio.interceptors.add(const TokenInterceptor());
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      compact: false,
    ),
  );
  return dio;
}

Future<void> _initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PlaceResultAdapter());
}

Future<void> _initGoogleAutoCompletionRepos() async {
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
    },
  );

  final client = Dio(options)
    ..interceptors.add(
      DioCacheInterceptor(options: cacheOptions),
    );
  final remote = GoogleAutoCompletionRemote(client);

  final cityBox = await Hive.openBox<PlaceResult>('cityBox');
  final establishmentBox = await Hive.openBox<PlaceResult>('establishmentBox');

  getIt
    ..registerSingleton(
      GoogleAutoCompletionRepository(
        remote,
        'locality',
        GoogleAutoCompletionLastSelected(cityBox),
      ),
      instanceName: autoCompleteCity,
    )
    ..registerSingleton(
      GoogleAutoCompletionRepository(
        remote,
        'establishment',
        GoogleAutoCompletionLastSelected(establishmentBox),
      ),
      instanceName: autoCompleteEstablishment,
    );
}
