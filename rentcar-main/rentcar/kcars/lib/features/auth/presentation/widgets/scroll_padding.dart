import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ScrollPadding extends StatelessWidget {
  const ScrollPadding({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 6.w).copyWith(top: 2.w),
        child: child,
      ),
    );
  }
}
