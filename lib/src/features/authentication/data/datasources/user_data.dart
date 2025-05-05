import 'package:get/get.dart';
import 'package:lazervault/src/features/authentication/data/models/user_model.dart';

class UserProvider extends GetConnect {
  @override
  void onInit() {
    // All request will pass to jsonEncode so CasesModel.fromJson()
    httpClient.defaultDecoder = (map) => UserModel.fromJson(map as String);
    httpClient.baseUrl = 'https://api.covid19api.com';
    // baseUrl = 'https://api.covid19api.com'; // It define baseUrl to
    // Http and websockets if used with no [httpClient] instance

    // It's will attach 'apikey' property on header from all requests
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['apikey'] = '12345678';
      return request;
    });

    // Even if the server sends data from the country "Brazil",
    // it will never be displayed to users, because you remove
    // that data from the response, even before the response is delivered
    httpClient.addResponseModifier<UserModel>((request, response) {
      final model = response.body as Map<String, dynamic>;
      if ((model['countries'] as List).contains('Brazil')) {
        (model['countries'] as List).remove('Brazil');
      }
    });

    httpClient.addAuthenticator<dynamic>((request) async {
      final response = await get("http://yourapi/token");
      final token = response.body['token'];
      request.headers['Authorization'] = token;
      return request;
    });

    //Autenticator will be called 3 times if HttpStatus is
    //HttpStatus.unauthorized
    httpClient.maxAuthRetries = 3;
  }

  Future<Response<UserModel>> getUser(String path) => get(path);
}
