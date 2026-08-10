import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_notification.g.dart';

class NotificationState {
  final bool isEnabled;
  NotificationState({required this.isEnabled});
}

@riverpod
class Notifications extends _$Notifications {
  @override
  Future<NotificationState> build() async {
    // Load initial state
    final devicePermission = await Permission.notification.isGranted;
    final optedIn = OneSignal.User.pushSubscription.optedIn ?? false;

    // Set up OneSignal observer (only once)
    OneSignal.User.pushSubscription.addObserver((changes) {
      final optedIn = changes.current.optedIn;

      updateFromOneSignal(optedIn);
    });

    return NotificationState(isEnabled: devicePermission && optedIn);
  }

  Future<void> toggleNotifications(
    bool granted,
    bool value,
    String userId,
  ) async {
    if (value) {
      if (granted && userId.isNotEmpty) {
        await OneSignal.User.pushSubscription.optIn();
        await OneSignal.login(userId);
        state = AsyncData(NotificationState(isEnabled: true));
      } else {
        state = AsyncData(NotificationState(isEnabled: false));
      }
    } else {
      await OneSignal.User.pushSubscription.optOut();
      await OneSignal.logout();
      state = AsyncData(NotificationState(isEnabled: false));
    }
  }

  void updateFromOneSignal(bool optedIn) async {
    final devicePermission = await Permission.notification.isGranted;
    state = AsyncData(
      NotificationState(isEnabled: devicePermission && optedIn),
    );
  }
}
