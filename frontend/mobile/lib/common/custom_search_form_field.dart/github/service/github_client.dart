import 'dart:async';

import 'package:dio/dio.dart';
import 'package:recommendo/common/custom_search_form_field.dart/github/service/models/github_search_result.dart';
import 'package:recommendo/common/custom_search_form_field.dart/github/service/models/github_search_result_error.dart';

class GithubClient {
  GithubClient({
    Dio? dio,
    this.baseUrl = 'https://api.github.com/search/repositories?q=',
  }) : dio = dio ?? Dio();

  final String baseUrl;
  final Dio dio;

  Future<GithubSearchResult> search(String term) async {
    try {
      final response =
          await dio.getUri<Map<String, dynamic>>(Uri.parse('$baseUrl$term'));

      return GithubSearchResult.fromJson(response.data!);
    } on DioException catch (e) {
      throw GithubSearchResultError.fromJson(
        e.response!.data as Map<String, dynamic>,
      );
    }
  }
}
