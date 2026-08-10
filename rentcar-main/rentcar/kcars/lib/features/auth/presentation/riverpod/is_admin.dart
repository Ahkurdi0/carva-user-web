import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcars/configs/permissins.dart';
import 'package:kcars/features/auth/presentation/riverpod/current_user_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'is_admin.g.dart';

@riverpod
bool hasPermossion(Ref ref, [Permissions? permission]) {
  final userAsync = ref.watch(currentUserControllerProvider);
  return userAsync.maybeWhen(
    data: (user) =>
        user?.permissions.any(
          (permission) =>
              permission.permission.permissionName ==
              Permissions.companyCars.value,
        ) ??
        false,
    orElse: () => false,
  );
}
