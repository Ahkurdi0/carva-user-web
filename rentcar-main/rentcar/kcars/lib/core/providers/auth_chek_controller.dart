import 'package:kcars/core/providers/auth_check_states.dart';
import 'package:kcars/core/providers/update_chcker.dart';
import 'package:kcars/core/services/secure_storage.dart';
import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/auth/presentation/riverpod/auth_controller.dart';
import 'package:kcars/features/auth/presentation/riverpod/current_user_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_chek_controller.g.dart';

@riverpod
class AuthCheck extends _$AuthCheck {
  late SecureStorage _storage;

  @override
  Future<AuthState> build() async {
    _storage = sl<SecureStorage>();

    try {
      final user = await ref.read(currentUserControllerProvider.future);
      final onBoarding = await _storage.read("onboarding");
      final updateChecker = await ref.read(updateCheckerProvider.future);
      final newVersion = updateChecker?.isUpdateAvailable() ?? false;

      if (user != null) {
        await ref
            .read(authControllerProvider.notifier)
            .refreesh(isCheking: true);
      }
      return AuthState(
        user: user,
        updateAvailable: newVersion,
        isInitialized: true,
        onBoarding: onBoarding == "true",
        isLoading: false,
      );
    } catch (e) {
      final updateChecker = await ref.read(updateCheckerProvider.future);
      final newVersion = updateChecker?.isUpdateAvailable() ?? false;
      return AuthState(
        user: null,
        updateAvailable: newVersion,
        isInitialized: true,
        isLoading: false,
      );
    }
  }
}
