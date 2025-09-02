import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:motives_android_conversion/Service/api_basehelper.dart';
import 'package:http/http.dart' as http;

class Repository {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  var baseUrl =
      "http://services.zankgroup.com/motivesteang/index.php?route=api/user";

  var loginUrl =
      "http://services.zankgroup.com/motivesteang/index.php?route=api/user/login";
  final String attendanceUrl =
      "http://services.zankgroup.com/motivesteang/index.php?route=api/user/attendance";

  final String routeStartUrl =
      "http://services.zankgroup.com/motivesteang/index.php?route=api/user/routeStart";

  Future<http.Response> login(String email, String password) async {
    DateTime now = DateTime.now();

    String currentDate = DateFormat("dd-MMM-yyyy").format(now);
    String currentTime =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";

    try {
      final Map<String, dynamic> payload = {
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
        "app_version": "1.0.1",
      };

      print("PAYLOAD $payload");

      final body = {"request": jsonEncode(payload)};

      final response = await http.post(Uri.parse(loginUrl), body: body);
      if (response.statusCode == 200) {
        final box = GetStorage();
        box.write("email", email);
        box.write("password", password);
        box.write("email_auth", email);
        box.write("password-auth", password);
      }

      print("➡️ Sending: ${body}");
      print("⬅️ Status Code: ${response.statusCode}");
      print("⬅️ Response Body: ${response.body}");

      return response;
    } catch (e) {
      throw Exception("Login API failed: $e");
    }
  }

  Future<http.Response> attendance(
    String type,
    String userId,
    String lat,
    String lng,
  ) async {
    DateTime now = DateTime.now();

    String currentDate = DateFormat("dd-MMM-yyyy").format(now);
    String currentTime =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";

    try {
      final Map<String, dynamic> payload = {
        "type": type,
        "user_id": userId,
        "latitude": lat,
        "longitude": lng,
        "device_id": "e95a9ab3bba86f821",
        "act_type": "ATTENDANCE",
        "action": "IN",
        "att_time": currentTime,
        "att_date": currentDate,
        "misc": "0",
        "dist_id": "0",
        "app_version": "1.0.1",
      };

      print("PAYLOAD $payload");

      final body = {"request": jsonEncode(payload)};

      final response = await http.post(Uri.parse(attendanceUrl), body: body);
      if (response.statusCode == 200) {}

      print("➡️ Sending: ${body}");
      print("⬅️ Status Code: ${response.statusCode}");
      print("⬅️ Response Body: ${response.body}");

      return response;
    } catch (e) {
      throw Exception("Login API failed: $e");
    }
  }


   Future<http.Response> startRouteApi(
    String type,
    String userId,
    String lat,
    String lng,
    String activityType,
    String action
  ) async {
    DateTime now = DateTime.now();

    String currentDate = DateFormat("dd-MMM-yyyy").format(now);
    String currentTime =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";

    try {
      final Map<String, dynamic> payload = {
        "type": type,
        "user_id": userId,
        "latitude": lat,
        "longitude": lng,
        "device_id": "e95a9ab3bba86f821",
        "activity_type": activityType,
        "action": action,
        "att_time": currentTime,
        "att_date": currentDate,
      };

      print("PAYLOAD $payload");

      final body = {"request": jsonEncode(payload)};

      final response = await http.post(Uri.parse(routeStartUrl), body: body);
      if (response.statusCode == 200) {}

      print("➡️ Sending: ${body}");
      print("⬅️ Status Code: ${response.statusCode}");
      print("⬅️ Response Body: ${response.body}");

      return response;
    } catch (e) {
      throw Exception("Login API failed: $e");
    }
  }
}
