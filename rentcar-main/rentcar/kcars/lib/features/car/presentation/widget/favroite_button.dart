import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:kcars/features/car/application/car_controller.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/post_location.dart';
import 'package:kcars/translations/locale_keys.g.dart';

class FavoriteButton extends HookConsumerWidget {
  const FavoriteButton({
    super.key,
    required this.isFavorited,
    this.onTap,
    required this.car,
    this.brandId,
    this.param,
    this.isLoggedIn = false,
  });
  final VoidCallback? onTap;
  final bool isFavorited;
  final Car? car;
  final String? brandId;
  final PostLocation? param;
  final bool isLoggedIn;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    final scale = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.3), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    final prevFavorited = usePrevious(isFavorited);
    useEffect(() {
      if (prevFavorited != null && prevFavorited != isFavorited) {
        controller.forward(from: 0);
      }
      return null;
    }, [isFavorited]);

    return GestureDetector(
      onTap: () {
        if (!isLoggedIn) {
          showCustomAlert(
            context,
            content: LocaleKeys.alertMessages_loginToFavorite.tr(),
            primaryButtonText: LocaleKeys.buttons_login.tr(),
            closeButton: true,
            buttonColor: context.primary,
            primaryAction: () => context.router.push(LoginRoute()),
          );
          return;
        }

        if (car != null) {
          ref.read(carControllerProvider.notifier).favoriteCar(car!, brandId);
        }
      },
      child: ScaleTransition(
        scale: scale,
        child: IconLoadaer(
          isFavorited ? AppIcons.favorited : AppIcons.favorite,
          key: ValueKey(isFavorited),
        ),
      ),
    );
  }
}
