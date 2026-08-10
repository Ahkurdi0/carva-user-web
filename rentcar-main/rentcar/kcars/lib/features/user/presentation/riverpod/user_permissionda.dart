import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcars/features/auth/presentation/riverpod/current_user_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_permissionda.g.dart';

@riverpod
Future<List<String>> userPermissions(Ref ref) async {
  final user = await ref.watch(currentUserControllerProvider.future);
  final permissions = user?.permissions;

  return permissions?.map((e) => e.permission.permissionName).toList() ?? [];
}
