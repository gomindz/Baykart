import 'package:agri_tech/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;

class BadgeIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;

  const BadgeIcon({
    Key? key,
    required this.text,
    required this.icon,
    this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: badge.Badge(
        showBadge: text.isNotEmpty
            ? int.parse(text) > 0
                ? true
                : false
            : false,
        position: badge.BadgePosition.topEnd(top: 2, end: 4),
        badgeAnimation: const badge.BadgeAnimation.fade(),
        badgeContent: Text(
          int.parse(text) > 9 ? '9+' : text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: IconButton(
          icon: Icon(
            icon,
            color: color ?? primaryColor,
            size: 30,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
