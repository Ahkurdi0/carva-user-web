import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcars/features/auth/presentation/riverpod/current_user_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'is_logged_in.g.dart';

@riverpod
bool isLoggedIn(Ref ref) {
  final userAsync = ref.watch(currentUserControllerProvider);
  return userAsync.maybeWhen(data: (user) => user != null, orElse: () => false);
}
