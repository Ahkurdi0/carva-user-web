import 'package:flutter/material.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:sizer/sizer.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    this.onDelete,
    this.onEdit,
    this.leading,
    this.titleStyle,
    this.subtitle,
    this.onAdd,
  });
  final String title;
  final String? subtitle;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onAdd;
  final Widget? leading;
  final TextStyle? titleStyle;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: titleStyle),
      subtitle: subtitle != null
          ? Text(subtitle!, style: context.caption)
          : null,
      leading: leading,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onAdd != null)
            IconButton(
              onPressed: onAdd,
              icon: Icon(Icons.add, size: 4.w),
            ),
          if (onEdit != null)
            IconButton(
              onPressed: onEdit,
              icon: Icon(Icons.edit, size: 4.w),
            ),
          if (onDelete != null)
            IconButton(
              onPressed: onDelete,
              icon: Icon(Icons.delete, size: 4.w),
            ),
        ],
      ),
    );
  }
}
