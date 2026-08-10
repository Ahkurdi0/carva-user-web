import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/user/presentation/riverpod/user_permissionda.dart';
import 'package:kcars/features/user/presentation/view/admin_user_options.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_options_provider.g.dart';

@riverpod
List<AdminUserOptions> adminuUserSettings(Ref ref, Profile profile) {
  return adminUserOptions(profile, ref);
}

@riverpod
List<AdminUserOptions> adminUserOptionsScreen(Ref ref, Profile profile) {
  final userPermissions =
      ref.watch(userPermissionsProvider).asData?.value ?? [];

  final options = ref.watch(adminuUserSettingsProvider(profile));

  final aall = options
      .where((option) => userPermissions.contains(option.permission))
      .toList();

  return aall;
}
