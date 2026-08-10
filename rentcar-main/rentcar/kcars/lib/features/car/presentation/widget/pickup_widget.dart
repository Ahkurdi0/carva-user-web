import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PickUpWidget extends StatelessWidget {
  const PickUpWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
    this.isLoading = false,
    this.isSelected = true,
    this.onTap,
  });
  final String title;
  final String icon;
  final String value;
  final bool isLoading;
  final bool isSelected;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44.w,
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: context.secondaryContainer,
          borderRadius: BorderRadius.circular(100.w),
          border: Border.all(width: 0.1, color: context.surfaceContainer),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isLoading ? Bone.circle(size: 6.2.w) : IconLoadaer(icon),
            Gap(4.w),
            Text(value, style: context.body),
          ],
        ),
      ),
    );
  }
}
