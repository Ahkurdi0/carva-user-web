import 'package:flutter/material.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:sizer/sizer.dart';

class CustomTabbar extends StatelessWidget {
  const CustomTabbar({
    super.key,
    required this.tabs,
    this.isScrollable = false,
    this.tabAlignment = TabAlignment.start,
    this.decoration = const BoxDecoration(),
    this.controller,
  });

  final List<Tab> tabs;
  final bool isScrollable;
  final TabAlignment tabAlignment;
  final Decoration decoration;
  final TabController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 11.w,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      decoration: decoration,
      child: TabBar(
        controller: controller,
        isScrollable: isScrollable,
        tabAlignment: tabAlignment,
        splashFactory: NoSplash.splashFactory,
        splashBorderRadius: BorderRadius.circular(100.w),
        dividerHeight: 0,
        indicatorPadding: EdgeInsets.zero,
        labelColor: context.onSurface,
        indicatorWeight: .1,
        unselectedLabelColor: context.outline,
        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.w),
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: context.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(100.w),
        ),
        tabs: tabs,
      ),
    );
  }
}
