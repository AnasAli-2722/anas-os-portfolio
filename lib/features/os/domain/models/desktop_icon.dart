import 'package:flutter/material.dart';

enum IconType { folder, application, link, file }

class DesktopIcon {
  final String id;
  final String label;
  final IconData icon;
  final IconType type;
  final Color? color;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final String? url;
  final Widget? customIcon;

  const DesktopIcon({
    required this.id,
    required this.label,
    required this.icon,
    this.type = IconType.application,
    this.color,
    this.onTap,
    this.onDoubleTap,
    this.url,
    this.customIcon,
  });

  DesktopIcon copyWith({
    String? id,
    String? label,
    IconData? icon,
    IconType? type,
    Color? color,
    VoidCallback? onTap,
    VoidCallback? onDoubleTap,
    String? url,
    Widget? customIcon,
  }) {
    return DesktopIcon(
      id: id ?? this.id,
      label: label ?? this.label,
      icon: icon ?? this.icon,
      type: type ?? this.type,
      color: color ?? this.color,
      onTap: onTap ?? this.onTap,
      onDoubleTap: onDoubleTap ?? this.onDoubleTap,
      url: url ?? this.url,
      customIcon: customIcon ?? this.customIcon,
    );
  }
}
