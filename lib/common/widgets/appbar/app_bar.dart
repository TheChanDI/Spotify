import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool? showIcon;
  final bool? showBackIcon;
  const BasicAppBar({super.key, this.title, this.showIcon, this.showBackIcon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: (showBackIcon ?? false)
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? Colors.white.withOpacity(0.03)
                      : Colors.black.withOpacity(0.04),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
              ))
          : null,
      title: (showIcon ?? false)
          ? SizedBox(height: 35, child: SvgPicture.asset(AppVectors.logo))
          : title,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
