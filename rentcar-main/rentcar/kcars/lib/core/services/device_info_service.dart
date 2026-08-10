import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:kcars/features/auth/data/model/session.dart';

class DeviceInfoSerice {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  Future<BaseDeviceInfo?> call() async {
    return await deviceInfo.deviceInfo;
  }

  Future<AndroidDeviceInfo?> androidInfo() async {
    try {
      final info = await deviceInfo.androidInfo;
      return info;
    } catch (e) {
      return null;
    }
  }

  Future<IosDeviceInfo?> iosInfo() async {
    return await deviceInfo.iosInfo;
  }

  Future<Session?> getDeviceInfo() async {
    if (Platform.isAndroid) {
      final dd = await androidInfo();
      return Session(
        sessionId: "0",
        isPhysicalDevice: "${dd?.isPhysicalDevice}",
        model: "${dd?.model}",
        identifierForVendor: "${dd?.serialNumber}",
        name: "${dd?.device}",
        systemName: "${dd?.display}",
      );
    }
    if (Platform.isIOS) {
      final dd = await iosInfo();
      return Session(
        sessionId: "0",
        isPhysicalDevice: '${dd?.isPhysicalDevice}',
        model: "${dd?.model}",
        identifierForVendor: "${dd?.identifierForVendor}",
        name: "${dd?.name}",
        systemName: "${dd?.systemName}",
        localizedModel: "${dd?.localizedModel}",
        systemVersion: "${dd?.systemVersion}",
      );
    }
    return null;
  }
}
