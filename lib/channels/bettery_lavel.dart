import 'package:flutter/services.dart';

class BetterLevel {
  static const platform = const MethodChannel('battery');
  String? errorMessage = 'Unknown battery level.';

  Future<int?> getBatteryLevel() async {
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      errorMessage = null;
      return result;
    } on PlatformException catch (e) {
      errorMessage = "Failed to get battery level: '${e.message}'.";
    }
  }
}
