import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/entity/local_place_result.dart';

class GoogleAutoCompletionLocal {
  const GoogleAutoCompletionLocal(this._box);

  final Box<LocalPlaceResult> _box;

  Future<void> saveSelected(LocalPlaceResult item) async {
    final list = _box.values
        .where((element) => element.value != item.value)
        .toList()
      ..insert(0, item);

    await _box.clear();
    return _box.putAll(list.asMap());
  }

  List<LocalPlaceResult> getAll({int? length}) {
    if (length == null) {
      return _box.values.toList();
    }
    return _box.values.take(length).toList();
  }

  Future<int> clearCache() {
    return _box.clear();
  }

  Future<int> cacheSize() {
    if (kIsWeb) {
      return Future.value(0);
    } else {
      return File(_box.path!).length();
    }
  }
}
