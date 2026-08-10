import 'package:kcars/features/car/data/model/post_location.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'user_location.g.dart';

@riverpod
class UserLocation extends _$UserLocation {
  @override
  PostLocation build([bool? explorer]) {
    ref.keepAlive();
    return PostLocation();
  }

  void update(PostLocation location) {
    state = location;
  }
}
