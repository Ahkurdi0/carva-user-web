import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/user/presentation/riverpod/user_permissionda.dart';
import 'package:kcars/features/user/presentation/view/user_details_tabs.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_details_tab.g.dart';

@riverpod
List<UserDetailsTabs> userDetailsScreens(Ref ref, Profile profile) {
  return userDetailsTabScreens(profile);
}

@riverpod
List<UserDetailsTabs> userDetailsTabs(Ref ref, Profile profile) {
  final userPermissions =
      ref.watch(userPermissionsProvider).asData?.value ?? [];

  final options = ref.watch(userDetailsScreensProvider(profile));

  return options
      .where((option) => userPermissions.contains(option.permissions.name))
      .toList();
}
