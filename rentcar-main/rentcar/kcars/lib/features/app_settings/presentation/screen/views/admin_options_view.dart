import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcars/features/app_settings/presentation/riverpod/admin_otpion_screens.dart';

class AdminSettings extends ConsumerWidget {
  const AdminSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingss = ref.watch(adminOtionsScreensProvider);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: settingss.length,
      itemBuilder: (context, index) {
        return settingss[index].child;
      },
    );
  }
}
