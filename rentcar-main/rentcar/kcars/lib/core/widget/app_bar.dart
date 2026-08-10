import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:kcars/features/user/presentation/view/supports_view.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

class HomeAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    this.hasBackButton = false,
    this.backgroundColor,
    this.widget,
  });
  final bool hasBackButton;
  final Color? backgroundColor;
  final Widget? widget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      scrolledUnderElevation: 0,
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: false,
      leading: hasBackButton
          ? CustomBackButton(appBarHasBackground: backgroundColor != null)
          : null,
      title: SafeArea(
        child: GestureDetector(
          child: Row(
            children: [
              Image.asset(AppIcons.carva, width: 24.w, height: 24.w),
              const Spacer(),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: context.label.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  backgroundColor: context.primaryContainer,
                  foregroundColor: context.onSurface,
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                ),
                onPressed: () {
                  showCustomBottomSheet(
                    context,
                    SupportsView(),
                    useRootNavigator: true,
                  );
                },
                child: Text(LocaleKeys.labels_rentCar.tr()),
              ),
              ?widget,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.hasBadge = false,
    this.hasBackground = false,
    this.iconColor,
    this.color,
  });
  final String icon;
  final VoidCallback? onTap;
  final bool hasBadge;
  final bool hasBackground;
  final Color? iconColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: hasBackground
            ? context.surface
            : color ?? context.surfaceContainerLowest,
      ),
      onPressed: onTap,
      icon: Badge(
        isLabelVisible: hasBadge,
        child: IconLoadaer(icon, color: iconColor),
      ),
    );
  }
}
