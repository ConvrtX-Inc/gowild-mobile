import 'package:flutter/material.dart';
import 'package:gowild_mobile/constants/colors.dart' as AppColorConstants;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    required this.titleText,
    Key? key,
    this.height = 80,
    this.onLeadingTap,
    this.actions,
    this.hideAppBar = false,
  }) : super(key: key);

  final double height;
  final String titleText;
  final VoidCallback? onLeadingTap;
  final List<Widget>? actions;
  final bool hideAppBar;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leadingWidth: hideAppBar ? 20 : 80,
      leading: hideAppBar
          ? SizedBox.shrink()
          : GestureDetector(
              onTap: onLeadingTap,
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xFFf9db97),
              ),
            ),
      title: Text(
        titleText,
        style: TextStyle(
            color: AppColorConstants.primaryYellow,
            fontWeight: FontWeight.w800,
            fontSize: 25),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
