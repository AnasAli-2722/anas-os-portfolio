import 'package:flutter/material.dart';
import 'desktop_layout.dart';
import 'mobile_layout.dart';

class OSLayout extends StatelessWidget {
  const OSLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use 800px as breakpoint for responsive design
        if (constraints.maxWidth > 800) {
          return const DesktopLayout();
        } else {
          return const MobileLayout();
        }
      },
    );
  }
}
