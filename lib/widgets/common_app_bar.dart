import 'package:flutter/material.dart';
import 'package:lingoganda_news/constants/app_colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar(
      {super.key, this.leadingWidget, this.titleWidget, this.trailingWidget});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final Widget? leadingWidget;
  final Widget? titleWidget;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryLight,
      elevation: 0,
      title: titleWidget,
      centerTitle: false,
      leading: leadingWidget,
      actions: trailingWidget != null ? [trailingWidget!] : [],
    );
  }
}
