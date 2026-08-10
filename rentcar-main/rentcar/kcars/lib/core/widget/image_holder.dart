import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/image_type.dart';
import 'package:kcars/core/services/info.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ImageHolder extends ConsumerWidget {
  final double? width, height;
  final String? image;
  final EdgeInsets? padding;
  final BoxFit? fit;
  final double? aspectRation;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final ImageType? type;
  final bool isLoading;

  const ImageHolder({
    super.key,
    this.width,
    this.height,
    this.image,
    this.type,
    this.padding,
    this.aspectRation,
    this.fit,
    this.borderRadius,
    this.color,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final w = width ?? 24.w;
    final h = height ?? 24.w;
    final radius = borderRadius ?? BorderRadius.circular(4.w);
    final bgColor = color ?? context.primary;
    final aspect = aspectRation ?? 1 / 1;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: radius),
      height: h,
      width: w,
      child: AspectRatio(
        aspectRatio: aspect,
        child: image != null
            ? CachedNetworkImage(
                imageUrl: "${Info.imageUrl}/$image",
                fit: fit,
                placeholder: (context, url) => Skeletonizer(
                  child: Container(
                    height: h,
                    width: w,
                    color: color ?? context.primary,
                  ),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Icon(
                    Icons.broken_image,
                    size: w * 0.4,
                    color: bgColor,
                  ),
                ),
              )
            : Container(
                height: height ?? 24.w,
                width: width ?? 24.w,
                decoration: BoxDecoration(borderRadius: radius),
                child: isLoading
                    ? SizedBox(
                        height: height ?? 24.w,
                        width: width ?? 24.w,
                        child: Image.asset(
                          "test/assets/car.png",
                          width: w,
                          height: h,
                          fit: fit,
                        ),
                      )
                    : Icon(
                        type == ImageType.profile || type == ImageType.company
                            ? Icons.person
                            : Icons.image,
                        size: w * 0.4,
                        color: bgColor,
                      ),
              ),
      ),
    );
  }
}
