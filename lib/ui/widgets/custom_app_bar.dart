import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gowild/constants/colors.dart';

class CustomAppBar extends HookWidget implements PreferredSizeWidget {
  const CustomAppBar({
    required this.titleText,
    super.key,
    this.height = 80,
    this.onLeadingTap,
  });

  final double height;
  final String titleText;
  final VoidCallback? onLeadingTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leadingWidth: 80,
      leading: GestureDetector(
        onTap: onLeadingTap,
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Color(0xFFf9db97),
        ),
      ),
      title: Text(
        titleText,
        style: const TextStyle(
          color: primaryYellow,
          fontWeight: FontWeight.w800,
          fontSize: 25,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
