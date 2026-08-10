import 'package:flutter/widgets.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:sizer/sizer.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({
    super.key,
    required this.child,
    this.backgroundColor,
  });
  final Widget child;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: context.surfaceContainerLowest, width: 1.w),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
