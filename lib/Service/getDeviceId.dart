import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

Future<String> getDeviceId() async {
  final deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
   
    final androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id;
  } else if (Platform.isIOS) {

    final iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor ?? "unknown";
  } else {
    return "unsupported-platform";
  }
}
