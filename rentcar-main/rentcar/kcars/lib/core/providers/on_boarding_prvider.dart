import 'package:kcars/core/providers/auth_chek_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'on_boarding_prvider.g.dart';

@riverpod
class OnBoarding extends _$OnBoarding {
  @override
  FutureOr<bool?> build() async {
    final resut = ref.watch(authCheckProvider).asData?.value;

    return resut?.onBoarding;
  }
}
