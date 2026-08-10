import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:kcars/core/widget/loading_emoty_state.dart';
import 'package:sizer/sizer.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    this.onPress,
    this.isActive = true,
    this.width,
    this.height,
    this.icon,
    this.color,
    this.textColor,
    this.isLoading = false,
    this.borderRadius,
    this.iconColor,
  });
  final String text;
  final VoidCallback? onPress;
  final bool isActive;
  final double? width;
  final Color? color;
  final Color? textColor;
  final double? height;
  final String? icon;
  final bool isLoading;
  final BorderRadiusGeometry? borderRadius;
  final Color? iconColor;
  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool isHighliyed = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(100.w),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white.withValues(alpha: 0.12),
          highlightColor: Colors.white.withValues(alpha: 0.06),
          onTap: () {
            if (widget.isLoading || !widget.isActive) {
              return;
            }
            widget.onPress?.call();
          },
          child: Ink(
            width: widget.width ?? 100.w,
            height: widget.height ?? 12.w,
            decoration: BoxDecoration(
              color: widget.isActive
                  ? widget.color ?? context.secondary
                  : Theme.of(context).highlightColor,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.isLoading
                      ? CircleLoading2()
                      : Row(
                          children: [
                            if (widget.icon != null) ...[
                              IconLoadaer(
                                widget.icon!,
                                width: 5.w,
                                color: widget.iconColor,
                              ),
                              Gap(2.w),
                            ],
                            Text(
                              widget.text,
                              style: context.button.copyWith(
                                color: widget.isActive
                                    ? widget.textColor ?? context.onPrimary
                                    : context.disabled,
                              ),
                            ),
                            if (widget.icon != null) ...[SizedBox(), Gap(1.w)],
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SecondaryButton extends StatefulWidget {
  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPress,
    this.isActive = true,
    this.width,
    this.height,
    this.icon,
    this.color,
    this.textColor,
    this.isLoading = false,
    this.borderRadius,
    this.borderColor,
    this.iconColor,
  });
  final String text;
  final VoidCallback onPress;
  final bool isActive;
  final double? width;
  final Color? color;
  final Color? textColor;
  final double? height;
  final String? icon;
  final bool isLoading;
  final BorderRadiusGeometry? borderRadius;
  final Color? borderColor;
  final Color? iconColor;

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  bool isHighliyed = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(100.w),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: context.onSurface.withValues(alpha: 0.08),
          highlightColor: context.onSurface.withValues(alpha: 0.04),
          onTap: () {
            if (widget.isLoading || !widget.isActive) {
              return;
            }
            widget.onPress();
          },
          child: Ink(
            width: widget.width ?? 100.w,
            height: widget.height ?? 12.w,

            decoration: BoxDecoration(
              border: Border.all(
                width: .2,
                color:
                    widget.borderColor ??
                    Theme.of(context).colorScheme.tertiaryContainer,
              ),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(100.w),
              color: widget.isActive
                  ? widget.color ?? Theme.of(context).colorScheme.surface
                  : Theme.of(context).highlightColor,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.isLoading
                      ? CircleLoading2(height: 6.w, width: 6.w)
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (widget.icon != null) ...[
                              IconLoadaer(
                                widget.icon!,
                                width: 5.w,
                                color: widget.iconColor,
                              ),
                              Gap(2.w),
                            ],
                            Text(
                              widget.text,
                              style: context.button.copyWith(
                                color: widget.isActive
                                    ? widget.textColor ?? context.onSurface
                                    : Theme.of(context).disabledColor,
                              ),
                            ),
                            if (widget.icon != null) ...[SizedBox(), Gap(1.w)],
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TertiaryButton extends StatelessWidget {
  const TertiaryButton({super.key, required this.title, this.onPress});
  final VoidCallback? onPress;
  final String title;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
        minimumSize: Size.zero,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.surface,
        textStyle: context.label,
      ),
      child: Text(title, style: context.label.copyWith(color: context.outline)),
    );
  }
}
