import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcars/configs/app_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'app_router_provider.g.dart';

@riverpod
// ignore: unsupported_provider_value
AppRouter appRouter(Ref ref) {
  return AppRouter(ref: ref);
}
