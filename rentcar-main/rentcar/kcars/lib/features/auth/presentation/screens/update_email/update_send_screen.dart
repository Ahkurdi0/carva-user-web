import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcars/features/auth/presentation/widgets/scroll_padding.dart';

@RoutePage()
class UpdateSendOtpScreen extends ConsumerWidget {
  const UpdateSendOtpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScrollPadding(child: Text("Update Send Otp Screen"));
  }
}
