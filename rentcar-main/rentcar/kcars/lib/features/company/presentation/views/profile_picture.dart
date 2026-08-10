import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:sizer/sizer.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture(
    this.imageUrl, {
    super.key,
    this.onTap,
    this.height,
    this.width,
    this.assetImage,
    this.isLoading = false,
  });
  final String? imageUrl;
  final File? assetImage;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: height ?? 25.w,
            width: width ?? 25.w,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Theme.of(context).highlightColor),
            ),
            child: assetImage != null
                ? Image.file(
                    assetImage!,
                    width: width ?? 25.w,
                    height: height ?? 25.w,
                    fit: BoxFit.cover,
                  )
                : imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(100.w),
                    child: ImageHolder(
                      image: imageUrl,
                      borderRadius: BorderRadius.circular(100.w),
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(Icons.image),
          ),
          PositionedDirectional(
            bottom: 0.w,
            end: 0,
            width: 8.w,
            child: CircleAvatar(
              backgroundColor: context.surfaceContainerLowest,
              radius: 4.w,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: isLoading
                    ? CupertinoActivityIndicator()
                    : Icon(Icons.add, size: 6.w, color: context.onSurface),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget(
    this.imageUrl, {
    super.key,
    this.onTap,
    this.height,
    this.width,
    this.assetImage,
  });
  final String? imageUrl;
  final File? assetImage;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: height ?? 25.w,
            width: width ?? 25.w,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Theme.of(context).highlightColor),
            ),
            child: assetImage != null
                ? Image.file(
                    assetImage!,
                    width: width ?? 25.w,
                    height: height ?? 25.w,
                    fit: BoxFit.cover,
                  )
                : imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(100.w),
                    child: ImageHolder(
                      image: imageUrl,
                      borderRadius: BorderRadius.circular(100.w),
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(Icons.image),
          ),
        ],
      ),
    );
  }
}
