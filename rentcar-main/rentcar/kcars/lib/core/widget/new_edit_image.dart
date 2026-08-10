import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:sizer/sizer.dart';

class NewEditImage extends StatelessWidget {
  final String? image;
  final String? selectedImage;
  final VoidCallback onTap;

  final double? width, height;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit? fit;
  final double? aspectRation;
  final EdgeInsets? padding;

  const NewEditImage({
    super.key,
    this.image,
    this.selectedImage,
    required this.onTap,
    this.width,
    this.height,
    this.borderRadius,
    this.fit,
    this.aspectRation,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: context.secondaryContainer,
        borderRadius: borderRadius ?? BorderRadius.circular(4.w),
        boxShadow: [
          BoxShadow(
            color: context.onSurface.withAlpha(20),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      height: height ?? 36.w,
      width: width ?? 36.w,
      child: InkWell(
        borderRadius: BorderRadius.circular(4.w),
        onTap: onTap,
        child: selectedImage == null
            ? ImageHolder(
                image: image,
                fit: fit,
                // aspectRation: aspectRation,
                padding: padding,
              )
            : ClipRRect(
                borderRadius: borderRadius ?? BorderRadius.circular(4.w),
                child: Platform.isIOS
                    ? Image.asset(selectedImage!, fit: BoxFit.cover)
                    : Image.file(File(selectedImage!), fit: BoxFit.cover),
              ),
      ),
    );
  }
}
