import 'package:motives_android_conversion/Service/api_basehelper.dart';
import 'package:http/http.dart' as http;

class Repository{
    ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

    final String baseUrl = "http://services.zankgroup.com/motivesteang/index.php?route=api/user/login";

  Future<http.Response> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        body: {
          "email": email,
          "pass": password,
          "latitude": "24.88732030562018",
          "longitude": "66.97987176813096",
          "device_id": "e95a9ab3bba86f821",
          "act_type": "LOGIN",
          "action": "IN",
          "att_time": "12:00:56",
          "att_date": "08-Aug-2025",
          "misc": "0",
          "dist_id": "0",
          "app_version": "1.0.1",
        },
      );

      return response;
    } catch (e) {
      throw Exception("Login API failed: $e");
    }
  }

  // Future<http.Response> login(
  //     String email, String password) async {
  //   return await _apiBaseHelper.post(
  //     path: ApiConstants.loginApi,
  //     body: {
  //       "email": email,
  //       "password": password,
  //     },
  //   );
  // } reository method key : request , value : {"email":"sohrab.ob@afriditea.com","pass":"password@786","latitude":"0.00","longitude":"0.00","device_id":"e95a9ab3bba86f821","act_type":"LOGIN","action":"IN","att_time":"12:00:56","att_date":"06-Jun-2024","misc":"0","dist_id":"0","app_version":"1.0.1"}
}