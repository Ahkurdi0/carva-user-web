import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

@RoutePage()
class ModalSheetScreen extends StatelessWidget {
  const ModalSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PagedSheet(
      key: const ValueKey('modal-sheet'),
      decoration: MaterialSheetDecoration(
        size: SheetSize.stretch,
        type: MaterialType.button,
        borderRadius: BorderRadius.vertical(top: Radius.circular(6.w)),
        clipBehavior: Clip.antiAlias,
        color: Colors.white,
      ),

      navigator: AutoRouter(),
    );
  }
}
