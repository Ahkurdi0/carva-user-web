import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
part 'shee_controller.g.dart';

@riverpod
// ignore: unsupported_provider_value
SheetController sheetController(Ref ref) {
  return SheetController();
}
