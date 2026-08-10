import 'package:flutter/material.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:kcars/features/car/data/model/enums.dart';
import 'package:sizer/sizer.dart';

class CustomLocationIcon extends StatelessWidget {
  const CustomLocationIcon({
    super.key,
    required this.imageUrl,
    this.color,
    this.markerType = MapMarkerType.car,
  });
  final String? imageUrl;
  final Color? color;
  final MapMarkerType markerType;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: -2.w,
                child: SizedBox(
                  width: 6.w,
                  height: 4.w,
                  child: CustomPaint(
                    painter: TrianglePainter(color: context.secondary),
                  ),
                ),
              ),
              Container(
                width: 8.w,
                height: 8.w,
                padding: EdgeInsets.all(.8.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.secondary,
                ),
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: imageUrl != null
                        ? ImageHolder(
                            image: imageUrl!,
                            width: 16.w,
                            height: 16.w,
                            fit: BoxFit.cover,
                          )
                        : IconLoadaer(AppIcons.locationP, width: 5.w),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color? color;

  TrianglePainter({super.repaint, this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color ?? const Color(0xff1C70D7)
      ..style = PaintingStyle.fill;

    double radius = size.width / 2;

    Path path = Path()
      ..moveTo(radius, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
