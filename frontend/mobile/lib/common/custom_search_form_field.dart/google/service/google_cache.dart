import 'package:recommendo/common/custom_search_form_field.dart/google/service/models/google_search_result.dart';

class GoogleMapsCache {
  final _cache = <String, GoogleMapsSearchResult>{};

  GoogleMapsSearchResult? get(String term) => _cache[term];

  void set(String term, GoogleMapsSearchResult result) => _cache[term] = result;

  bool contains(String term) => _cache.containsKey(term);

  void remove(String term) => _cache.remove(term);
}
