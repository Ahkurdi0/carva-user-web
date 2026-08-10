import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultSheetController(child: AutoRouter());
  }
}
