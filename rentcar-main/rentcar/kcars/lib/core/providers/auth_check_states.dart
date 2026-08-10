import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
part 'auth_check_states.mapper.dart';

@MappableClass()
class AuthState with AuthStateMappable {
  final Profile? user;
  final bool updateAvailable;
  final bool isInitialized;
  final bool? onBoarding;
  final bool isLoading;

  AuthState({
    this.user,
    this.updateAvailable = false,
    this.isInitialized = true,
    this.onBoarding = false,
    this.isLoading = true,
  });

  factory AuthState.initial() => AuthState(
    user: null,
    updateAvailable: false,
    isInitialized: false,
    onBoarding: false,
    isLoading: true,
  );
}
