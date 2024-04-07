import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recommendo/recommendo/service/payload_model.dart';

class AwsRepository {
  AwsRepository() : dio = Dio();
  final Dio dio;

  static const url =
      'https://3ldew20id8.execute-api.ca-central-1.amazonaws.com/test';

  Future<void> sendRequest() async {
    final token = await FirebaseAuth.instance.currentUser!.getIdToken();
    // final response = await dio.post(
    //   url,
    //   data: PayloadModel().toJson(),
    //   options: Options(
    //     headers: {
    //       'Authorization': 'Bearer $token',
    //       'Content-Type': 'application/json',
    //     },
    //   ),
    // );
    // print(response);
  }
}
