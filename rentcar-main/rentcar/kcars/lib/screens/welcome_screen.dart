import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/providers/auth_chek_controller.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/services/dio_service.dart';
import 'package:kcars/core/utils/launch_links.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/loading_emoty_state.dart';
import 'package:kcars/features/auth/data/model/auth.dart';
import 'package:kcars/features/auth/presentation/riverpod/auth_controller.dart';
import 'package:kcars/features/auth/presentation/riverpod/auth_states.dart';
import 'package:kcars/features/car/presentation/views/filters_data_view.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class WelcomeScreen extends StatefulHookConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen>
    with WidgetsBindingObserver {
  bool hasNavigated = false;
  bool _checkingAuth = false;
  bool _updateAvailable = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuth();
    });
  }

  Future<void> _checkAuth() async {
    if (_checkingAuth) return;
    _checkingAuth = true;
    try {
      debugPrint("Checking auth state...");
      final authState = await ref.read(authCheckProvider.future);
      debugPrint(
        "Auth state: user=${authState.user != null}, onBoarding=${authState.onBoarding}, updateAvailable=${authState.updateAvailable}",
      );
      if (!mounted) return;

      // Avoid redundant navigation
      if (hasNavigated &&
          authState.user != null &&
          context.router.current.name == MainRoute.name) {
        debugPrint("Already on MainRoute, skipping navigation");
        return;
      }
      if (hasNavigated &&
          authState.user == null &&
          context.router.current.name == NotLoggedInMainRoute.name) {
        debugPrint("Already on NotLoggedInMainRoute, skipping navigation");
        return;
      }

      await Future.delayed(const Duration(seconds: 3)); // Animation delay

      if (authState.onBoarding != true || authState.updateAvailable) {
        setState(() {
          _updateAvailable = authState.updateAvailable;
        });
        hasNavigated = true;
        debugPrint("Onboarding or update required, staying on WelcomeScreen");
        return;
      }

      hasNavigated = true;
      if (authState.user != null) {
        debugPrint("Navigating to MainRoute");
        context.router.replaceAll([MainRoute()]);
      } else {
        debugPrint("Navigating to NotLoggedInMainRoute");
        context.router.replaceAll([NotLoggedInMainRoute()]);
      }
    } catch (e) {
      debugPrint("Error checking auth: $e");
    } finally {
      _checkingAuth = false;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      debugPrint("App resumed, checking auth...");
      _checkAuth();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = useMemoized(() => context.locale.languageCode, [
      context.locale,
    ]);
    ref.listen(authControllerProvider, (prev, next) {
      if (next is SetOnBoardingCompleted) {
        debugPrint("Onboarding completed, navigating to NotLoggedInMainRoute");
        context.router.replace(NotLoggedInMainRoute());
      }
    });
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 100.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              SizedBox(
                height: 110.w,
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
              SlideAnimation(
                child: Text(
                  LocaleKeys.weclomce_title.tr(),
                  style: context.titleBold.copyWith(
                    fontSize: locale != "en" ? 21.sp : null,
                  ),
                ),
              ),
              Gap(2.w),
              SlideAnimation(
                child: Text(
                  LocaleKeys.weclomce_subtitle.tr(),
                  style: context.subTitle,
                ),
              ),
              Gap(16.w),
              OnBoardingButton(updateAvailable: _updateAvailable),
            ],
            ),
          ),
        ),
      ),
    );
  }
}

class OnBoardingButton extends HookConsumerWidget {
  const OnBoardingButton({super.key, required this.updateAvailable});
  final bool updateAvailable;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAuth = ref.watch(authCheckProvider);
    final data = asyncAuth.asData?.value;
    final auth = ref.watch(authControllerProvider);
    final isStillLoading = asyncAuth.isLoading || data == null;
    final shouldShowButton = data?.onBoarding == false || updateAvailable;

    return SlideAnimation(
      child: SizedBox(
        height: 38.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: isStillLoading
                  ? SizedBox(height: 12.w, child: CircleLoading())
                  : shouldShowButton
                  ? PrimaryButton(
                      isLoading: auth is SetOnBoardingLoading,
                      key: const ValueKey("get_started_button"),
                      width: 80.w,
                      text: updateAvailable
                          ? LocaleKeys.buttons_update.tr()
                          : LocaleKeys.buttons_getStarted.tr(),
                      onPress: () async {
                        if (updateAvailable) {
                          try {
                            final url = Platform.isAndroid
                                ? "https://play.google.com/store/apps/details?id=com.carvarent"
                                : "https://apps.apple.com/app/carva/id6753580784";
                            openLink(url);
                          } catch (_) {}
                          return;
                        }
                        await ref
                            .read(authControllerProvider.notifier)
                            .setOnBoarding();
                      },
                    )
                  : SizedBox(height: 12.w, child: CircleLoading()),
            ),
            if (shouldShowButton) ...[Gap(6.w), LanguagesView()],
          ],
        ),
      ),
    );
  }
}

class FadingMap extends HookWidget {
  const FadingMap({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 1000),
    )..forward();

    final fade = CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    final slide = Tween<Offset>(
      begin: const Offset(0, -0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    return FadeTransition(
      opacity: fade,
      child: SlideTransition(
        position: slide,
        child: SvgPicture.asset(AppIcons.iqMap, height: 84.w),
      ),
    );
  }
}

class FadeAnimate extends HookWidget {
  const FadeAnimate({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 1000),
    )..forward();

    final fade = CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    final slide = Tween<Offset>(
      begin: const Offset(0, -0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    return FadeTransition(
      opacity: fade,
      child: SlideTransition(position: slide, child: child),
    );
  }
}

final List<Offset> carPositions = [
  Offset(32.w, 10.w),
  Offset(7.w, 15.w),
  Offset(19.w, 16.w),
  Offset(26.w, 26.w),
  Offset(19.w, 40.w),
  Offset(11.w, 27.w),
  Offset(10, 37.w),
];

class CurvePainter extends CustomPainter {
  final Color pathColor;
  const CurvePainter({required this.pathColor});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = pathColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final w = size.width;
    final h = size.height;

    var path = Path();
    path.moveTo(0, h * 0.7);
    path.quadraticBezierTo(w / 2, h, w, h * 0.7);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Path buildCurvePath(Size size) {
  final w = size.width;
  final h = size.height;

  final path = Path();
  path.moveTo(0, h * 0.7);
  path.quadraticBezierTo(w / 2, h, w, h * 0.7);
  path.lineTo(w, 0);
  path.lineTo(0, 0);
  path.close();
  return path;
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => buildCurvePath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class AnimatedCarIcon extends HookWidget {
  final Duration delay;

  const AnimatedCarIcon({super.key, required this.delay});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 2000),
    );

    final scale = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutCubic,
    );

    useEffect(() {
      Future.delayed(delay, () {
        controller.forward();
      });
      return null;
    }, []);

    return ScaleTransition(
      scale: scale,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(0, 2)),
          ],
          shape: BoxShape.circle,
          color: context.onSurface,
        ),
        child: SvgPicture.asset(
          AppIcons.car,
          width: 5.2.w,
          height: 5.2.w,
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}

class AnimatedPhoneFrame extends HookWidget {
  final Widget child;
  const AnimatedPhoneFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 1500),
    )..forward();

    final fade = CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    final offset = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutQuad));

    return FadeTransition(
      opacity: fade,
      child: SlideTransition(
        position: offset,
        child: Material(
          color: Colors.transparent,
          shape: ContinuousRectangleBorder(
            side: BorderSide(
              color: context.onSurface,
              width: 4.0,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(16.w),
          ),
          child: Container(
            height: 100.w,
            width: 60.w,
            decoration: BoxDecoration(
              color: context.surface.withAlpha(100),
              borderRadius: BorderRadius.circular(8.w),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class SlideAnimation extends HookWidget {
  final Widget child;
  const SlideAnimation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 1500),
    )..forward();

    final fade = CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    final offset = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutQuad));

    return FadeTransition(
      opacity: fade,
      child: SlideTransition(position: offset, child: child),
    );
  }
}

class LanguagesView extends HookConsumerWidget {
  const LanguagesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = context.locale.languageCode;
    final changeLang = useMemoized(
      () => (String locale) async {
        GetIt.instance<DioService>().dio.options.headers["devicelang"] = locale;
        EasyLocalization.of(context)?.setLocale(Locale(locale));
        await OneSignal.User.getTags();
        await OneSignal.User.addTagWithKey("appLang", locale);
        ref
            .read(authControllerProvider.notifier)
            .updatePrefLang(Auth(prefLang: locale));
      },
      [],
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w).copyWith(bottom: 6.w),
      child: Row(
        spacing: 2.w,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomFilterChip(
            title: "کوردی",
            selected: locale == "ku",
            onTap: () => changeLang("ku"),
            selectedColor: context.primary,
          ),
          CustomFilterChip(
            title: "عربی",
            selected: locale == "ar",
            onTap: () => changeLang("ar"),
            selectedColor: context.primary,
          ),
          CustomFilterChip(
            title: "English",
            selected: locale == "en",
            onTap: () => changeLang("en"),
            selectedColor: context.primary,
          ),
        ],
      ),
    );
  }
}
