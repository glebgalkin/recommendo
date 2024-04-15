import 'package:dio/dio.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/github/models/github_search_result.dart';
import 'package:retrofit/retrofit.dart';

part 'github_remote.g.dart';

@RestApi()
abstract class GithubRemote {
  factory GithubRemote(Dio dio) = _GithubRemote;

  @GET('/search/repositories')
  Future<GithubSearchResult> search(@Query('q') String term);
}
