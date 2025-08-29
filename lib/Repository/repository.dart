import 'package:motives_android_conversion/Service/api_basehelper.dart';
import 'package:http/http.dart' as http;

class Repository{
    ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

final String baseUrl = "http://services.zankgroup.com/motivesteang/index.php?route=api/user/login";

Future<http.Response> login(String email, String password) async {
  DateTime now = DateTime.now();

  String currentDate = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
  String currentTime = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";

  try {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: {
        "email": email,
        "pass": password,
        "latitude": "0.00",
        "longitude": "0.00",
        "device_id": "e95a9ab3bba86f821",
        "act_type": "LOGIN",
        "action": "IN",
        "att_time": currentTime,
        "att_date": currentDate,
        "misc": "0",
        "dist_id": "0",
        "app_version": "1.0.1"
      },
    );

    return response;
  } catch (e) {
    throw Exception("Login API failed: $e");
  }
}

}