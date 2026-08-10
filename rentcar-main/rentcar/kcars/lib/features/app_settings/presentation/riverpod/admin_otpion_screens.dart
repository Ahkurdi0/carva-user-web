import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcars/features/app_settings/presentation/screen/views/admin_options_screens.dart';
import 'package:kcars/features/user/presentation/riverpod/user_permissionda.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'admin_otpion_screens.g.dart';

@riverpod
List<AdminSettingsScreen> adminSettings(Ref ref) {
  return adminOptions(ref);
}

@riverpod
List<AdminSettingsScreen> adminOtionsScreens(Ref ref) {
  final userPermissions =
      ref.watch(userPermissionsProvider).asData?.value ?? [];

  final options = ref.watch(adminSettingsProvider);

  return options
      .where((option) => userPermissions.contains(option.permission))
      .toList();
}
