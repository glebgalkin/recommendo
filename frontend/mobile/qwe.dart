void main() {
  try {
    print('here 1');
    throw CustomException();
  } on CustomException {
    print('HERE 2');
    throw Exception();
  } on Exception {
    print('HERE 3');
  }
}

class CustomException implements Exception {}
