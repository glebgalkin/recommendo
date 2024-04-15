import 'package:dio/dio.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_repository.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/search_result_error.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/github/github_remote.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/github/models/github_search_result.dart';

class GithubRepository extends BaseSearchRepository {
  const GithubRepository(this._remote);

  final GithubRemote _remote;

  @override
  Future<GithubSearchResult> search(String term) {
    try {
      return _remote.search(term);
    } on DioException {
      throw const SearchResultError('Service not availabe');
    }
  }
}
