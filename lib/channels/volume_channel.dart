import 'package:flutter/services.dart';

class VolumeChannel {
  MethodChannel platform = const MethodChannel('volume');

  static int? _maxVolume;
  Future<int> get maxVolume async {
    if (_maxVolume != null) return _maxVolume!;
    try {
      _maxVolume = await platform.invokeMethod('getMaxVolume');
      return _maxVolume ?? 100;
    } catch (e) {
      return 100;
    }
  }

  static int? _currentVolume;
  Future<int> get currentVolume async {
    if (_currentVolume != null) return _currentVolume!;
    try {
      _currentVolume = await platform.invokeMethod('getCurrentVolume');
      return _currentVolume ?? 0;
    } catch (e) {
      return 0;
    }
  }

  Future<void> setVolumeLevel(int level) async {
    try {
      await platform.invokeMethod('setVolumeLevel', {"level": level});
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}
