import 'package:flutter/material.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:sizer/sizer.dart';

class SearchFeild extends StatelessWidget {
  const SearchFeild({
    super.key,
    required this.controller,
    required this.onChanged,
    this.isLoading = false,
    this.hint,
  });
  final TextEditingController controller;
  final Function(String)? onChanged;
  final bool isLoading;
  final String? hint;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autocorrect: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
        border: InputBorder.none,
        hintText: hint,
        filled: true,
        fillColor: context.secondaryContainer,
        suffix: isLoading ? const CircularProgressIndicator.adaptive() : null,
      ),
      onChanged: onChanged,
    );
  }
}
