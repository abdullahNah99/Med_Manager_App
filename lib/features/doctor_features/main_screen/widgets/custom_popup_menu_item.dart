import 'package:flutter/material.dart';

class CustomPopupMenuItem<T> extends PopupMenuItem<T> {
  final String text;
  final IconData icon;
  final Color iconColor;
  CustomPopupMenuItem({
    super.key,
    required this.text,
    required this.icon,
    required this.iconColor,
    super.onTap,
  }) : super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: iconColor,
              ),
              Text(text),
            ],
          ),
        );
}
