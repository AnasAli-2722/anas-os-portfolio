import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protfolio/core/theme/app_theme.dart';
import '../providers/window_provider.dart';
import 'package:protfolio/shared/widgets/glass_window.dart';
import '../widgets/taskbar.dart';
import '../providers/wallpaper_provider.dart';

class DesktopLayout extends ConsumerWidget {
  const DesktopLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final windows = ref.watch(windowProvider);
    final wallpaper = ref.watch(wallpaperProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          // Background Wallpaper
          Positioned.fill(
            child: _buildWallpaper(wallpaper),
          ),
          
          // Windows Stack
          ...windows.map((window) {
            return Positioned(
              key: ValueKey(window.id),
              left: window.position.dx,
              top: window.position.dy,
              child: Offstage(
                offstage: window.isMinimized,
                child: RepaintBoundary(
                  child: GlassWindow(window: window),
                ),
              ),
            );
          }).toList(),

          // Taskbar
          const Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(child: Taskbar()),
          ),
        ],
      ),
    );
  }

  Widget _buildWallpaper(String id) {
    List<Color> colors;
    switch (id) {
      case 'cyber_red':
        colors = [Color(0xFF200122), Color(0xFF6f0000)];
        break;
      case 'void_black':
        colors = [Color(0xFF000000), Color(0xFF434343)];
        break;
      case 'neon_blue':
        colors = [Color(0xFF000428), Color(0xFF004e92)];
        break;
      case 'rose_gold':
        colors = [Color(0xFF100007), Color(0xFFB76E79)];
        break;
      case 'pink_dream':
        colors = [Color(0xFF2E0219), Color(0xFFFF007F)];
        break;
      case 'cotton_candy':
        colors = [Color(0xFFFF99CC), Color(0xFF99CCFF)];
        break;
      case 'deep_space':
      default:
        colors = [Color(0xFF0F0C29), Color(0xFF302B63), Color(0xFF24243E)];
        break;
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
    );
  }
}
