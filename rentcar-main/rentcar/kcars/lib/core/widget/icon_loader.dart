import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconLoadaer extends StatelessWidget {
  const IconLoadaer(
    this.icon, {
    super.key,
    this.color,
    this.height,
    this.width,
    this.boxFit = BoxFit.cover,
  });
  final String icon;
  final Color? color;
  final double? width;
  final double? height;
  final BoxFit boxFit;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      width: width,
      height: height,
      fit: boxFit,
      colorFilter: color != null
          ? ColorFilter.mode(
              color != null ? color! : Colors.transparent,
              BlendMode.srcIn,
            )
          : null,
    );
  }
}
