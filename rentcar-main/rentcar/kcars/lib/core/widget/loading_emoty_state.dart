import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class CircleLoading extends StatelessWidget {
  const CircleLoading({super.key, this.height, this.width});
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width ?? 24.w,
        height: height ?? 24.w,
        child: DotLottieLoader.fromAsset(
          AppIcons.circle,
          frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
            if (dotlottie != null) {
              return Lottie.memory(dotlottie.animations.values.single);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class CircleLoading2 extends StatelessWidget {
  const CircleLoading2({super.key, this.height, this.width});
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width ?? 20.w,
        height: height ?? 20.w,
        child: DotLottieLoader.fromAsset(
          AppIcons.circle2,
          frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
            if (dotlottie != null) {
              return Lottie.memory(dotlottie.animations.values.single);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, this.height, this.width});
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width ?? 100.w,
        height: height ?? 100.w,
        child: DotLottieLoader.fromAsset(
          AppIcons.empty,
          frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
            if (dotlottie != null) {
              return Lottie.memory(
                dotlottie.animations.values.single,
                fit: BoxFit.fill,
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, this.emptyMessage, required this.icon});
  final String? emptyMessage;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconLoadaer(icon, width: 50.w),
          Gap(2.w),
          Text(
            emptyMessage ?? LocaleKeys.empty_cars.tr(),
            style: context.caption.copyWith(color: context.outline),
          ),
        ],
      ),
    );
  }
}
