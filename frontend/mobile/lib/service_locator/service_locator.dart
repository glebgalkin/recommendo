import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recommendo/app/recommendo/data/entity/recommendation_response_entity.dart';
import 'package:recommendo/app/recommendo/data/local/recommendations_local.dart';
import 'package:recommendo/app/recommendo/data/recommendations_repository_impl.dart';
import 'package:recommendo/app/recommendo/data/remote/recommendations_remote.dart';
import 'package:recommendo/app/recommendo/service/recommendations_service.dart';
import 'package:recommendo/app/recommendo/service/repository/recommendations_repository.dart';
import 'package:recommendo/app/recommendo/view/bloc/create_recommendation_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  final dio = _initDio();

  await _initHive();
  final recommendationsBox =
      await Hive.openBox<RecommendationResponseEntity>('recommendationsBox');

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
