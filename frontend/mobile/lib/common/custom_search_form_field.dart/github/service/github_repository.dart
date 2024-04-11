import 'dart:async';

import 'package:recommendo/common/custom_search_form_field.dart/github/service/github_cache.dart';
import 'package:recommendo/common/custom_search_form_field.dart/github/service/github_client.dart';
import 'package:recommendo/common/custom_search_form_field.dart/github/service/models/github_search_result.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_repository.dart';

class GithubRepository extends BaseSearchRepository {
  const GithubRepository(this.cache, this.client);

  final GithubCache cache;
  final GithubClient client;

  @override
  Future<GithubSearchResult> search(String term) async {
    final cachedResult = cache.get(term);
    if (cachedResult != null) {
      return cachedResult;
    }
    final result = await client.search(term);
    cache.set(term, result);
    return result;
  }
}
