import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/providers/connectivity.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:kcars/screens/welcome_screen.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class ConnectivityScreen extends StatefulHookConsumerWidget {
  const ConnectivityScreen({super.key});

  @override
  ConsumerState<ConnectivityScreen> createState() => _ConnectivityScreenState();
}

class _ConnectivityScreenState extends ConsumerState<ConnectivityScreen> {
  @override
  Widget build(BuildContext context) {
    var network = ref.watch(networkAwareProvider);

    if (network == NetworkStatus.on) {
      context.router.replaceAll([const WelcomeRoute()]);
    }

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: 100.w,
          child: Column(
            children: [
              SizedBox(
                height: 120.w,
                width: 100.w,
                child: CustomPaint(
                  foregroundPainter: CurvePainter(
                    pathColor: context.surfaceContainerLowest,
                  ),
                  child: ClipPath(
                    clipper: CurveClipper(),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        FadingMap(),
                        AnimatedPhoneFrame(
                          child: Stack(
                            children: carPositions.asMap().entries.map((entry) {
                              final index = entry.key;
                              final offset = entry.value;
                              return Positioned(
                                top: offset.dy,
                                right: offset.dx,
                                child: AnimatedCarIcon(
                                  delay: Duration(milliseconds: index * 150),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SlideAnimation(child: IconLoadaer(AppIcons.wifiOFF, width: 20.w)),
              Gap(6.w),
              SlideAnimation(
                child: Text(
                  LocaleKeys.alertMessages_noInternet.tr(),
                  textAlign: TextAlign.center,
                  style: context.titleBold.copyWith(fontSize: 19.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
