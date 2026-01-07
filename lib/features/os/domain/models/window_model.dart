import 'package:flutter/material.dart';

class WindowModel {
  final String id;
  final String title;
  final Widget content;
  final Offset position;
  final Size size;
  final bool isMinimized;
  final bool isMaximized;
  final bool isOpen;

  WindowModel({
    required this.id,
    required this.title,
    required this.content,
    this.position = const Offset(100, 100),
    this.size = const Size(600, 400),
    this.isMinimized = false,
    this.isMaximized = false,
    this.isOpen = true,
  });

  WindowModel copyWith({
    String? id,
    String? title,
    Widget? content,
    Offset? position,
    Size? size,
    bool? isMinimized,
    bool? isMaximized,
    bool? isOpen,
  }) {
    return WindowModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      position: position ?? this.position,
      size: size ?? this.size,
      isMinimized: isMinimized ?? this.isMinimized,
      isMaximized: isMaximized ?? this.isMaximized,
      isOpen: isOpen ?? this.isOpen,
    );
  }
}
