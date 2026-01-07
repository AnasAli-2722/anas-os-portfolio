import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protfolio/core/theme/app_theme.dart';
import '../../../../os/presentation/providers/wallpaper_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Appearance', style: AppTheme.darkTheme.textTheme.displayMedium),
          const SizedBox(height: 20),
          Text('Wallpaper', style: AppTheme.darkTheme.textTheme.bodyLarge),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _WallpaperOption(color: Color(0xFF0F0C29), label: 'Deep Space'),
                _WallpaperOption(color: Color(0xFF6f0000), label: 'Cyber Red'),
                _WallpaperOption(color: Color(0xFF000000), label: 'Void Black'),
                _WallpaperOption(color: Color(0xFF004e92), label: 'Neon Blue'),
                _WallpaperOption(color: Color(0xFFB76E79), label: 'Rose Gold'),
                _WallpaperOption(color: Color(0xFFFF007F), label: 'Pink Dream'),
                _WallpaperOption(color: Color(0xFFFF99CC), label: 'Cotton Candy'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WallpaperOption extends ConsumerWidget {
  final Color color;
  final String label;

  const _WallpaperOption({required this.color, required this.label});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        // We are using a simple string to represent the "type" of wallpaper for now, 
        // since we are using gradients/colors in DesktopLayout.
        // Let's map labels to IDs.
        String wallpaperId = 'default';
        if (label == 'Deep Space') wallpaperId = 'deep_space';
        if (label == 'Cyber Red') wallpaperId = 'cyber_red';
        if (label == 'Void Black') wallpaperId = 'void_black';
        if (label == 'Neon Blue') wallpaperId = 'neon_blue';
        if (label == 'Rose Gold') wallpaperId = 'rose_gold';
        if (label == 'Pink Dream') wallpaperId = 'pink_dream';
        if (label == 'Cotton Candy') wallpaperId = 'cotton_candy';
        
        ref.read(wallpaperProvider.notifier).setWallpaper(wallpaperId);
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
