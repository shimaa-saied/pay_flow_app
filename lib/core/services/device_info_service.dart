// core/services/device_info_service.dart
//
// Singleton Pattern:
// عايزين instance واحدة بس من الخدمة دي طول عمر التطبيق، عشان مفيش داعي
// نعمل query لمعلومات الجهاز أكتر من مرة. الـ constructor خاص (private)،
// والوصول الوحيد بيكون عبر DeviceInfoService.instance.

import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoService {
  DeviceInfoService._internal();

  static final DeviceInfoService instance = DeviceInfoService._internal();

  final DeviceInfoPlugin _plugin = DeviceInfoPlugin();

  String? _cachedModel;
  String? _cachedOsVersion;

  /// بيرجع (اسم الموديل، نسخة نظام التشغيل).
  /// النتيجة بتتخزن بعد أول نداء (cache) عشان منعملش الاستعلام غير مرة واحدة.
  Future<({String model, String osVersion})> getDeviceInfo() async {
    if (_cachedModel != null && _cachedOsVersion != null) {
      return (model: _cachedModel!, osVersion: _cachedOsVersion!);
    }

    try {
      if (Platform.isAndroid) {
        final info = await _plugin.androidInfo;
        _cachedModel = info.model;
        _cachedOsVersion = 'Android ${info.version.release}';
      } else if (Platform.isIOS) {
        final info = await _plugin.iosInfo;
        _cachedModel = info.utsname.machine;
        _cachedOsVersion = 'iOS ${info.systemVersion}';
      } else {
        _cachedModel = 'Unknown device';
        _cachedOsVersion = Platform.operatingSystem;
      }
    } catch (_) {
      // ملحوظة معمارية: أي فشل هنا (منصة غير مدعومة، إلخ) مش لازم يوقع
      // الشاشة كلها — بنرجّع قيمة افتراضية بدل ما نرمي Exception.
      _cachedModel = 'غير معروف';
      _cachedOsVersion = 'غير معروف';
    }

    return (model: _cachedModel!, osVersion: _cachedOsVersion!);
  }
}
