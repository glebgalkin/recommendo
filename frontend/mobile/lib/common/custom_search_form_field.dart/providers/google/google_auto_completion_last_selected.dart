import 'package:recommendo/common/custom_search_form_field.dart/providers/google/models/city_result.dart';

class GoogleAutoCompletionLastSelected {
  const GoogleAutoCompletionLastSelected(this._list);

  final List<PlaceResult> _list;

  void saveSelected(PlaceResult item) {
    if (_list.length == 5) {
      _list.removeLast();
    }
    _list.insert(0, item);
  }

  List<PlaceResult> getLastSelected() {
    return _list;
  }
}
