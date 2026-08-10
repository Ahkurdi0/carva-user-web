import 'package:kcars/core/services/service_location.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upgrader/upgrader.dart';
part 'update_chcker.g.dart';

@Riverpod(keepAlive: true)
class UpdateChecker extends _$UpdateChecker {
  late Upgrader _upgrader;
  @override
  FutureOr<Upgrader?> build() async {
    _upgrader = sl<Upgrader>();
    try {
      await _upgrader.initialize();

      return _upgrader;
    } catch (e) {
      return null;
    }
  }
}
