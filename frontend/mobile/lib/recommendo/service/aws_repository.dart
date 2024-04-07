import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AwsRepository {
  final Dio dio;

  static const url =
      'https://3ldew20id8.execute-api.ca-central-1.amazonaws.com/test';

  AwsRepository() : dio = Dio();

  Future<void> sendRequest() async {
    final token = await FirebaseAuth.instance.currentUser!.getIdToken();
    final response = await dio.get(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    print(response);
  }
}
