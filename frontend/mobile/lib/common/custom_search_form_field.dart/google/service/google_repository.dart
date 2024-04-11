import 'dart:async';

import 'package:recommendo/common/custom_search_form_field.dart/google/service/google_cache.dart';
import 'package:recommendo/common/custom_search_form_field.dart/google/service/google_client.dart';
import 'package:recommendo/common/custom_search_form_field.dart/google/service/models/google_search_result.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_repository.dart';

class GoogleMapsRepository extends BaseSearchRepository {
  const GoogleMapsRepository(this.cache, this.client);

  final GoogleMapsCache cache;
  final GoogleMapsRemote client;

  @override
  Future<GoogleMapsSearchResult> search(String term) async {
    final cachedResult = cache.get(term);
    if (cachedResult != null) {
      return cachedResult;
    }
    final result = await client.search(term);
    cache.set(term, result);
    return result;
  }
}
