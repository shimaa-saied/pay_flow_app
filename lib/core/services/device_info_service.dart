import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class DeviceInfoService {
  DeviceInfoService._();
  static final DeviceInfoService instance = DeviceInfoService._();

  ({String model, String osVersion})? _cached;

  Future<({String model, String osVersion})> getDeviceInfo() async {
    if (_cached != null) return _cached!;
    try {
      final plugin = DeviceInfoPlugin();
      if (defaultTargetPlatform == TargetPlatform.android) {
        final info = await plugin.androidInfo;
        _cached = (model: info.model, osVersion: 'Android ${info.version.release}');
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        final info = await plugin.iosInfo;
        _cached = (model: info.utsname.machine, osVersion: info.systemVersion);
      } else {
        _cached = (model: 'Unknown', osVersion: 'Unknown');
      }
    } catch (_) {
      _cached = (model: 'Unknown', osVersion: 'Unknown');
    }
    return _cached!;
  }
}