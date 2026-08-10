import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Future<void> showLocationAlert(
    BuildContext context, {
    required String content,
    required String primaryButtonText,
    required VoidCallback primaryAction,
  }) async {
    if (!context.mounted) return;
    showCustomAlert(
      context,
      closeButton: false,
      content: content,
      buttonColor: context.primary,
      primaryButtonText: primaryButtonText,
      primaryAction: primaryAction,
    );
  }

  Future<Position?> handleAndroidLocation(BuildContext context) async {
    if (!await Geolocator.isLocationServiceEnabled()) return null;

    PermissionStatus status = await Permission.location.status;

    if (status.isGranted) {
      return await Geolocator.getCurrentPosition();
    }

    if (status.isDenied || status.isRestricted) {
      if (!context.mounted) return null;
      await showLocationAlert(
        context,
        content: LocaleKeys.permissions_location_pickLocation.tr(),
        primaryButtonText: LocaleKeys.buttons_next.tr(),
        primaryAction: () async {
          status = await Permission.location.request();
        },
      );

      if (await Permission.location.isGranted) {
        return await Geolocator.getCurrentPosition();
      }
      return null;
    }

    if (status.isPermanentlyDenied) {
      if (!context.mounted) return null;
      await showLocationAlert(
        context,
        content: LocaleKeys.permissions_location_permissionDenied.tr(),
        primaryButtonText: "Open Settings",
        primaryAction: () async {
          await openAppSettings();
        },
      );
      return null;
    }

    return null;
  }

  // ====== iOS PERMISSION HANDLER ======
  Future<Position?> handleIOSLocation(BuildContext context) async {
    if (!await Geolocator.isLocationServiceEnabled()) return null;

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return await Geolocator.getCurrentPosition();
    }

    if (permission == LocationPermission.denied) {
      if (!context.mounted) return null;
      await showLocationAlert(
        context,
        content: LocaleKeys.permissions_location_pickLocation.tr(),
        primaryButtonText: LocaleKeys.buttons_next.tr(),
        primaryAction: () async {
          permission = await Geolocator.requestPermission();
          if (context.mounted) {}
        },
      );

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        return await Geolocator.getCurrentPosition();
      }
      return null;
    }

    if (permission == LocationPermission.deniedForever) {
      if (!context.mounted) return null;
      await showLocationAlert(
        context,
        content: LocaleKeys.permissions_location_permissionDenied.tr(),
        primaryButtonText: "Open Settings",
        primaryAction: () async {
          await Geolocator.openLocationSettings();
          if (context.mounted) {}
        },
      );
      return null;
    }

    return null;
  }

  // ====== SHARED PERMISSION CHECKER ======
  Future<Position?> handleLocationPermission(BuildContext context) async {
    if (Platform.isAndroid) {
      return await handleAndroidLocation(context);
    } else if (Platform.isIOS) {
      return await handleIOSLocation(context);
    } else {
      return null;
    }
  }

  Future<bool?> checkLocationPermission(BuildContext context) async {
    final position = await handleLocationPermission(context);
    return position != null;
  }
}

final ImagePicker _picker = ImagePicker();

/// Select a single image from gallery
Future<File?> selectImage() async {
  try {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image != null ? File(image.path) : null;
  } catch (_) {
    return null;
  }
}

/// Select multiple images from gallery
Future<List<XFile>?> selectMultipleImages() async {
  try {
    final List<XFile> images = await _picker.pickMultiImage(
      requestFullMetadata: false,
      imageQuality: 50,
    );
    return images.isNotEmpty ? images : null;
  } catch (_) {
    return null;
  }
}

/// Check and request necessary permission
Future<bool> _checkGalleryPermission() async {
  if (Platform.isAndroid) {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    final isAndroid13OrAbove = deviceInfo.version.sdkInt >= 33;
    return isAndroid13OrAbove
        ? true
        : await Permission.storage.status.isGranted;
  } else {
    final status = await Permission.photos.status;
    return status.isGranted || status.isLimited;
  }
}

/// Handles permission and returns selected image
Future<File?> handleImageSelection() async {
  final hasPermission = await _checkGalleryPermission();

  if (hasPermission) {
    return await selectImage();
  } else {
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      if (status.isGranted) {
        return await selectImage();
      }
    } else {
      final status = await Permission.photos.request();
      if (status.isGranted) {
        return await selectImage();
      }
    }
  }
  return null;
}

/// Main image picker with alert dialog if needed
Future<File?> selectImageWithPermissionPrompt(BuildContext context) async {
  final hasPermission = await _checkGalleryPermission();

  if (!hasPermission) {
    if (!context.mounted) return null;

    await showCustomAlert(
      context,
      content: LocaleKeys.permissions_selectImage_desc.tr(),
      primaryButtonText: LocaleKeys.buttons_next.tr(),
      closeButton: false,
      primaryAction: () async {
        await handleImageSelection();
      },
    );
    return null;
  } else {
    return await selectImage();
  }
}

handleNotification() async {
  try {
    await OneSignal.Notifications.requestPermission(true);
  } catch (_) {}
}

Future<bool> notificaPermission(BuildContext context) async {
  final status = await Permission.notification.status;

  if (status.isGranted || status.isLimited || status.isProvisional) {
    return true;
  }

  if (status.isDenied) {
    if (context.mounted) {
      await showCustomAlert(
        context,
        content: LocaleKeys.permissions_notification_desc.tr(),
        primaryButtonText: LocaleKeys.buttons_next.tr(),
        closeButton: true,
        primaryAction: () async {
          try {
            await OneSignal.Notifications.requestPermission(true);
          } catch (_) {}
        },
      );
    }
    return await Permission.notification.isGranted;
  }

  if (status.isPermanentlyDenied) {
    await showCustomAlert(
      context,
      content: LocaleKeys.permissions_notification_permanent.tr(),
      primaryButtonText: LocaleKeys.buttons_openSettings.tr(),
      closeButton: true,
      buttonColor: context.primary,
      primaryAction: () async {
        try {
          await openAppSettings();
        } catch (_) {}
      },
    );
    return await Permission.notification.isGranted;
  }

  return false;
}
