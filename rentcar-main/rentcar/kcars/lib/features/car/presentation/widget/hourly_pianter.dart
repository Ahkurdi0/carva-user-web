import 'dart:math';

import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

class HourlyDurationSelector extends StatefulWidget {
  final Function(int)? onHourSelected;
  final int initialHour;
  final int maxHour;
  const HourlyDurationSelector({
    super.key,
    this.initialHour = 1,
    this.maxHour = 24,
    this.onHourSelected,
  });

  @override
  HourlyDurationSelectorState createState() => HourlyDurationSelectorState();
}

class HourlyDurationSelectorState extends State<HourlyDurationSelector>
    with SingleTickerProviderStateMixin {
  late int selectedHour;
  late AnimationController _controller;
  late Animation<double> _animation;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    selectedHour = widget.initialHour;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    progress = selectedHour / 24;

    _animation = AlwaysStoppedAnimation(progress); // initially no animation
  }

  void animateToHour(int newHour) {
    final newProgress = newHour / 24;
    _animation =
        Tween<double>(begin: progress, end: newProgress).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOut),
        )..addListener(() {
          setState(() {});
        });

    _controller.reset();
    _controller.forward();
    progress = newProgress;
    selectedHour = newHour;
  }

  void _handleTouch(Offset localPosition, Size size) {
    final center = size.center(Offset.zero);
    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;
    double angle = atan2(dy, dx); // -pi to pi
    angle += pi / 2; // rotate so top is 0
    if (angle < 0) angle += 2 * pi; // make 0 to 2pi range

    final hour = (angle / (2 * pi) * 24).round();

    if (hour > widget.maxHour || hour < widget.initialHour) return;

    if (hour == 0) return;

    if (hour != selectedHour) {
      animateToHour(hour);
      widget.onHourSelected?.call(hour);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(58.w, 58.w);
        return Center(
          child: GestureDetector(
            onPanDown: (details) => _handleTouch(details.localPosition, size),
            onPanUpdate: (details) => _handleTouch(details.localPosition, size),
            child: CustomPaint(
              size: size,
              painter: HourlyDurationPainter(
                progress: _animation.value,
                selectedHour: selectedHour,
                progressColor: context.primary,
                borderColor: context.surfaceContainerLow,
                hourStyle: context.titleBold.copyWith(
                  fontSize: 26.sp,
                  color: context.primary,
                  fontWeight: FontWeight.w800,
                ),
                labelStyle: context.label2Bold.copyWith(color: context.outline),
                dotColor: context.outline,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class HourlyDurationPainter extends CustomPainter {
  final double progress; // between 0 and 1
  final int selectedHour;
  final Color? borderColor;
  final Color? progressColor;
  final Color? handColor;
  final Color? labelsColor;
  final Color? hoursColor;
  final Color? dotColor;
  final TextStyle? hourStyle;
  final TextStyle? labelStyle;

  HourlyDurationPainter({
    required this.progress,
    required this.selectedHour,
    this.borderColor,
    this.progressColor,
    this.handColor,
    this.labelsColor,
    this.hoursColor,
    this.dotColor,
    this.hourStyle,
    this.labelStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2 - 12; // 12 for padding

    final backgroundPaint = Paint()
      ..color = borderColor ?? Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24;

    final progressPaint = Paint()
      ..color = progressColor ?? Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 24;

    // Full background arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi,
      false,
      backgroundPaint,
    );

    // Animate progress arc sweep angle
    final sweepAngle = progress * 2 * pi;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );

    const totalHours = 24;

    final hourDotPaint = Paint()..color = dotColor ?? Colors.black;
    final selectedDotPaint = Paint()..color = Colors.white;
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < totalHours; i++) {
      final angle = (i / totalHours) * 2 * pi;
      final x = center.dx + radius * cos(angle - pi / 2);
      final y = center.dy + radius * sin(angle - pi / 2);
      final dotOffset = Offset(x, y);

      canvas.drawCircle(dotOffset, 4, hourDotPaint);

      final textRadius = radius - 30;
      final textOffset = Offset(
        center.dx + textRadius * cos(angle - pi / 2),
        center.dy + textRadius * sin(angle - pi / 2),
      );

      textPainter.text = TextSpan(
        text: i.toString(),
        style: TextStyle(fontSize: 12.sp, color: Colors.black),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        textOffset - Offset(textPainter.width / 2, textPainter.height / 2),
      );
    }

    // White dot at end of animated arc
    final angle = sweepAngle - pi / 2;
    final dotX = center.dx + radius * cos(angle);
    final dotY = center.dy + radius * sin(angle);
    final selectedDotOffset = Offset(dotX, dotY);

    final whiteBorderPaint = Paint()
      ..color = handColor ?? Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawCircle(selectedDotOffset, 9, whiteBorderPaint);
    canvas.drawCircle(selectedDotOffset, 8, selectedDotPaint);

    // Center text for selected hour
    // final centerTextPainter = TextPainter(
    //   textAlign: TextAlign.center,
    //   textDirection: TextDirection.ltr,
    // );

    final labelText = LocaleKeys.labels_hourP.plural(selectedHour).tr();
    // selectedHour == 1 ? 'hour' : 'hours';
    final labelTextPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    labelTextPainter.text = TextSpan(text: labelText, style: labelStyle);
    labelTextPainter.layout();

    final hourTextPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    hourTextPainter.text = TextSpan(text: '$selectedHour', style: hourStyle);
    hourTextPainter.layout();

    final totalHeight = hourTextPainter.height + labelTextPainter.height + 4;
    final centerOffset = Offset(
      center.dx - hourTextPainter.width / 2,
      center.dy - totalHeight / 2,
    );

    hourTextPainter.paint(canvas, centerOffset);

    labelTextPainter.paint(
      canvas,
      Offset(
        center.dx - labelTextPainter.width / 2,
        centerOffset.dy + hourTextPainter.height + 4,
      ),
    );

    // centerTextPainter.paint(
    //   canvas,
    //   center -
    //       Offset(centerTextPainter.width / 2, centerTextPainter.height / 2),
    // );
  }

  @override
  bool shouldRepaint(covariant HourlyDurationPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.selectedHour != selectedHour;
  }
}
