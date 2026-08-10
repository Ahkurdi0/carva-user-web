import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hint;
  final String? label;
  final String? helperText;
  final int? maxLength;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String? value)? validator;
  final bool readOnly;
  final GlobalKey<FormState>? formKey;
  final void Function(String)? onChanged;
  final bool multiLine;
  final bool autoFocus;
  final FocusNode? focus;
  final VoidCallback? onTap;
  final double? maxHeight;
  final bool isPhoneNumber;
  final Widget? suffixIcon;
  final Function(dynamic)? onCountrySelected;
  final String? coutryCode;
  final String? initialValue;
  final AutovalidateMode? autovalidateMode;
  final VoidCallback? onEditingComplete;
  final TextDirection? textDirection;
  final Widget? helperWidget;
  final Widget? prefixIcon;
  final String? selectedCoutryCode;
  final bool isPassword;
  final Color? filledColor;
  final bool showCounterText;
  final Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  const AppTextField({
    super.key,
    this.controller,
    this.hint,
    this.label,
    this.maxLength,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.readOnly = false,
    this.multiLine = false,
    this.autoFocus = false,
    this.formKey,
    this.onChanged,
    this.focus,
    this.onTap,
    this.maxHeight,
    this.isPhoneNumber = false,
    this.coutryCode,
    this.suffixIcon,
    this.onCountrySelected,
    this.initialValue,
    this.helperText,
    this.autovalidateMode,
    this.onEditingComplete,
    this.textDirection,
    this.helperWidget,
    this.selectedCoutryCode,
    this.prefixIcon,
    this.isPassword = false,
    this.filledColor,
    this.showCounterText = false,
    this.onFieldSubmitted,
    this.textInputAction,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool isFocused = false;
  final FocusNode focus = FocusNode();

  bool isHidden = true;
  @override
  void initState() {
    super.initState();
    focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    focus.removeListener(_onFocusChange);

    widget.focus?.dispose();
    focus.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isFocused = focus.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: EdgeInsets.only(bottom: 2.w),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: context.label.copyWith(
                color: isFocused && !widget.readOnly
                    ? context.onSurface
                    : context.outline,
              ),
              child: Text(widget.label!),
            ),
          ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(1.5.w)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxHeight: widget.maxHeight ?? 20.w,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: TextFormField(
                        onFieldSubmitted: widget.onFieldSubmitted,
                        textInputAction: widget.textInputAction,
                        textDirection: widget.textDirection,
                        onEditingComplete: widget.onEditingComplete,
                        autovalidateMode: widget.autovalidateMode,
                        enableSuggestions: false,
                        autocorrect: false,
                        initialValue: widget.initialValue,
                        onTap: widget.onTap,
                        autofocus: widget.autoFocus,
                        focusNode: focus,
                        maxLines: widget.multiLine ? null : 1,
                        onChanged: widget.onChanged,
                        validator:
                            widget.validator ??
                            (value) => widget.isPhoneNumber
                                ? value!.length < 10
                                      ? LocaleKeys.validations_phone.tr()
                                      : null
                                : value!.isNotEmpty
                                ? null
                                : LocaleKeys.validations_required.tr(),
                        maxLength: widget.maxLength,
                        keyboardType: widget.keyboardType,
                        inputFormatters: [
                          ...?widget.inputFormatters,
                          if (widget.isPhoneNumber)
                            FilteringTextInputFormatter.deny(RegExp(r'^0')),
                        ],
                        controller: widget.controller,

                        readOnly: widget.readOnly,
                        style: context.label,
                        obscureText: widget.isPassword ? isHidden : false,
                        errorBuilder: (context, errorText) => Text(
                          errorText,
                          style: context.overline.copyWith(
                            color: context.error,
                          ),
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          suffixIconConstraints: BoxConstraints(
                            minHeight: 10.w,
                            maxHeight: 10.w,
                          ),
                          prefixIconConstraints: BoxConstraints(
                            minHeight: 10.w,
                            maxHeight: 10.w,
                          ),
                          suffixIcon: widget.isPassword
                              ? IconButton(
                                  padding: EdgeInsets.all(0.w),
                                  onPressed: () {
                                    isHidden = !isHidden;
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    isHidden
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    size: 5.w,
                                    color: context.outline,
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.all(0.w),
                                  child: widget.suffixIcon != null
                                      ? widget.suffixIcon!
                                      : const Text(""),
                                ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 0.w,
                          ),

                          hintStyle: context.label.copyWith(
                            color: context.outline,
                          ),
                          counterText: widget.showCounterText ? null : "",

                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          hintText: widget.hint,
                          fillColor: widget.readOnly
                              ? context.surfaceContainerLow
                              : widget.filledColor ??
                                    context.surfaceContainerLowest,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.5.w),
                            borderSide: BorderSide(
                              color: widget.readOnly
                                  ? context.outline
                                  : context.onSurface,
                              width: 1.4,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.5.w),
                            borderSide: BorderSide(
                              color: context.outline.withValues(alpha: 0.5),
                              width: 1,
                            ),
                          ),
                          errorStyle: context.label.copyWith(
                            color: context.error,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.5.w),
                            borderSide: BorderSide(
                              color: context.error,
                              width: 1.2,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.5.w),
                            borderSide: BorderSide(
                              color: context.error,
                              width: 1.4,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.5.w),
                            borderSide: BorderSide(
                              color: context.outline.withValues(alpha: 0.5),
                              width: 1,
                            ),
                          ),
                          filled: true,
                          prefixIcon: widget.prefixIcon != null
                              ? Padding(
                                  padding: EdgeInsets.all(4.w),
                                  child: widget.prefixIcon!,
                                )
                              : widget.isPhoneNumber
                              ? Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        child: IntrinsicHeight(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: 4.w,
                                                  right: 2.w,
                                                ),
                                                child: Text(
                                                  widget.selectedCoutryCode ==
                                                              null ||
                                                          widget
                                                              .selectedCoutryCode!
                                                              .isEmpty
                                                      ? "+964"
                                                      : widget
                                                            .selectedCoutryCode!,
                                                  style: context.label.copyWith(
                                                    color: isFocused
                                                        ? context.onSurface
                                                        : context.outline,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (widget.helperText != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w).copyWith(top: 1.w),
            child: Text(
              widget.helperText!,
              style: context.label.copyWith(color: context.outline),
            ),
          ),
        if (widget.helperWidget != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w).copyWith(top: 1.w),
            child: widget.helperWidget,
          ),
      ],
    );
  }
}
