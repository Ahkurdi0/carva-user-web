import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:sizer/sizer.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title, required this.subTitle});
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(20.w),
        Text(title, style: context.titleBold),
        Gap(2.w),
        Text(subTitle, style: context.caption),
        Gap(10.w),
      ],
    );
  }
}
