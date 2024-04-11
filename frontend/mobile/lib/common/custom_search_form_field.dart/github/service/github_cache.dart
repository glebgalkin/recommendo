import 'package:recommendo/common/custom_search_form_field.dart/github/service/models/github_search_result.dart';

class GithubCache {
  final _cache = <String, GithubSearchResult>{};

  GithubSearchResult? get(String term) => _cache[term];

  void set(String term, GithubSearchResult result) => _cache[term] = result;

  bool contains(String term) => _cache.containsKey(term);

  void remove(String term) => _cache.remove(term);
}
