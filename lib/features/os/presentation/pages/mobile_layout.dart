import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protfolio/core/theme/app_theme.dart';
import 'package:protfolio/features/apps/monitor/presentation/pages/monitor_screen.dart';
import 'package:protfolio/features/apps/settings/presentation/pages/settings_screen.dart';
import 'package:protfolio/features/apps/store/presentation/pages/store_screen.dart';
import 'package:protfolio/features/apps/terminal/presentation/pages/terminal_screen.dart';
import 'package:protfolio/features/os/presentation/providers/wallpaper_provider.dart';
import 'package:protfolio/shared/widgets/digital_clock.dart';

class MobileLayout extends ConsumerWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallpaper = ref.watch(wallpaperProvider);

    return Scaffold(
      body: Stack(
        children: [
          // Wallpaper
          Positioned.fill(
            child: _buildWallpaper(wallpaper),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                const _StatusBar(),
                const SizedBox(height: 40),
                _buildClock(),
                const SizedBox(height: 40),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 4,
                    padding: const EdgeInsets.all(20),
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    children: [
                      _MobileAppIcon(
                        icon: Icons.terminal,
                        label: 'Terminal',
                        color: Colors.black,
                        onTap: () => _openApp(context, 'Terminal', const TerminalScreen()),
                      ),
                      _MobileAppIcon(
                        icon: Icons.shopping_bag,
                        label: 'Store',
                        color: Colors.blueAccent,
                        onTap: () => _openApp(context, 'Store', const StoreScreen()),
                      ),
                      _MobileAppIcon(
                        icon: Icons.monitor_heart,
                        label: 'Monitor',
                        color: Colors.greenAccent,
                        onTap: () => _openApp(context, 'System', const MonitorScreen()),
                      ),
                      _MobileAppIcon(
                        icon: Icons.settings,
                        label: 'Settings',
                        color: Colors.grey,
                        onTap: () => _openApp(context, 'Settings', const SettingsScreen()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openApp(BuildContext context, String title, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(title, style: AppTheme.darkTheme.textTheme.bodyLarge),
            backgroundColor: AppTheme.background,
            iconTheme: const IconThemeData(color: AppTheme.accent),
          ),
          body: page,
        ),
      ),
    );
  }

  Widget _buildClock() {
    return DigitalClock(
      timeStyle: AppTheme.darkTheme.textTheme.displayLarge?.copyWith(
        fontSize: 60,
        fontWeight: FontWeight.w200,
        color: Colors.white.withOpacity(0.9),
      ),
      dateStyle: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
        color: Colors.white.withOpacity(0.7),
      ),
    );
  }

  Widget _buildWallpaper(String id) {
    List<Color> colors;
    switch (id) {
      case 'cyber_red':
        colors = [const Color(0xFF200122), const Color(0xFF6f0000)];
        break;
      case 'void_black':
        colors = [const Color(0xFF000000), const Color(0xFF434343)];
        break;
      case 'neon_blue':
        colors = [const Color(0xFF000428), const Color(0xFF004e92)];
        break;
      case 'rose_gold':
        colors = [const Color(0xFF100007), const Color(0xFFB76E79)];
        break;
      case 'pink_dream':
        colors = [const Color(0xFF2E0219), const Color(0xFFFF007F)];
        break;
      case 'cotton_candy':
        colors = [const Color(0xFFFF99CC), const Color(0xFF99CCFF)];
        break;
      case 'deep_space':
      default:
        colors = [const Color(0xFF0F0C29), const Color(0xFF302B63), const Color(0xFF24243E)];
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

class _StatusBar extends StatelessWidget {
  const _StatusBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          const Icon(Icons.signal_cellular_alt, color: Colors.white, size: 16),
          const SizedBox(width: 5),
          const Text('5G', style: TextStyle(color: Colors.white, fontSize: 12)),
          const Spacer(),
          const Icon(Icons.wifi, color: Colors.white, size: 16),
          const SizedBox(width: 10),
          const Icon(Icons.battery_full, color: Colors.white, size: 16),
        ],
      ),
    );
  }
}

class _MobileAppIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _MobileAppIcon({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withOpacity(0.5)),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
