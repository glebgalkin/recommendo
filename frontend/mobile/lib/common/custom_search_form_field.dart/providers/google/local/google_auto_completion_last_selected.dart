import 'package:hive_flutter/hive_flutter.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/models/place_result.dart';

class GoogleAutoCompletionLastSelected {
  const GoogleAutoCompletionLastSelected(this._box);

  final Box<PlaceResult> _box;

  // TODO(Konyaka1): Refactor this bullshit
  Future<void> saveSelected(PlaceResult item) {
    final list = _box.values.toList()..insert(0, item);
    if (list.length > 5) {
      list.removeLast();
    }
    return _box.putAll(list.asMap());
  }

  List<PlaceResult> getLastSelected() {
    return _box.values.toList();
  }
}
