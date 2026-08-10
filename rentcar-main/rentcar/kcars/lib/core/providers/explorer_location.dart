import 'package:kcars/features/car/data/model/post_location.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'explorer_location.g.dart';

@riverpod
class ExplorerLocation extends _$ExplorerLocation {
  @override
  PostLocation build() {
    ref.keepAlive();
    return PostLocation();
  }

  void update(PostLocation location) {
    state = location;
  }
}
