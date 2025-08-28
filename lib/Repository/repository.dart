import 'package:motives_android_conversion/Service/api_basehelper.dart';
import 'package:http/http.dart' as http;
import '../Constants/api_constants.dart';

class Repository{
    ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<http.Response> login(
      String email, String password) async {
    return await _apiBaseHelper.post(
      path: ApiConstants.loginApi,
      body: {
        "email": email,
        "password": password,
      },
    );
  }
}