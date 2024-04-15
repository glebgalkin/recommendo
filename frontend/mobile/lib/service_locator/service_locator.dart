import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recommendo/app/recommendo/data/entity/recommendation_response_entity.dart';
import 'package:recommendo/app/recommendo/data/local/recommendations_local.dart';
import 'package:recommendo/app/recommendo/data/recommendations_repository_impl.dart';
import 'package:recommendo/app/recommendo/data/remote/recommendations_remote.dart';
import 'package:recommendo/app/recommendo/service/recommendations_service.dart';
import 'package:recommendo/app/recommendo/service/repository/recommendations_repository.dart';
import 'package:recommendo/app/recommendo/view/bloc/create_recommendation_cubit.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/github/github_remote.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/github/github_repository.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/google_auto_completion_remote.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/google_auto_completion_repository.dart';
import 'package:uuid/uuid.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  final dio = _initDio();

  await _initHive();
  final recommendationsBox =
      await Hive.openBox<RecommendationResponseEntity>('recommendationsBox');

  _initGithubRepo();
  _initGoogleAutoCompletionRepos();

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
  final options = BaseOptions(
    baseUrl: 'https://foodapi.dzolotov.tech',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  );
  return Dio(options);
}

Future<void> _initHive() {
  return Hive.initFlutter();
}

void _initGithubRepo() {
  final cacheOptions = CacheOptions(
    store: MemCacheStore(),
    policy: CachePolicy.forceCache,
    hitCacheOnErrorExcept: List.empty(),
    maxStale: const Duration(minutes: 1),
  );
  final options = BaseOptions(
    baseUrl: 'https://api.github.com',
    connectTimeout: const Duration(seconds: 1),
    receiveTimeout: const Duration(seconds: 1),
  );
  final client = Dio(options)
    ..interceptors.add(
      DioCacheInterceptor(options: cacheOptions),
    );
  final remote = GithubRemote(client);
  getIt.registerSingleton(GithubRepository(remote));
}

void _initGoogleAutoCompletionRepos() {
  final cacheOptions = CacheOptions(
    store: MemCacheStore(),
    policy: CachePolicy.forceCache,
    hitCacheOnErrorExcept: List.empty(),
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

  getIt.registerSingleton(
    GoogleAutoCompletionRepository(remote, '(cities)'),
    instanceName: autoCompleteCity,
  );
}
