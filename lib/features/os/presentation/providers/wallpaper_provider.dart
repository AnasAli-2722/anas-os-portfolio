import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

class WallpaperNotifier extends Notifier<String> {
  static const _key = 'selected_wallpaper';

  @override
  String build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getString(_key) ?? 'deep_space';
  }

  Future<void> setWallpaper(String wallpaper) async {
    state = wallpaper;
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_key, wallpaper);
  }
}

final wallpaperProvider = NotifierProvider<WallpaperNotifier, String>(() {
  return WallpaperNotifier();
});

// Dynamic accent color provider based on wallpaper
final accentColorProvider = Provider<Color>((ref) {
  final wallpaper = ref.watch(wallpaperProvider);

  switch (wallpaper) {
    case 'cyber_red':
      return const Color(0xFFFF0040);
    case 'void_black':
      return const Color(0xFF9E9E9E);
    case 'neon_blue':
      return const Color(0xFF00D4FF);
    case 'rose_gold':
      return const Color(0xFFFFB6C1);
    case 'pink_dream':
      return const Color(0xFFFF007F);
    case 'cotton_candy':
      return const Color(0xFFFF99CC);
    case 'deep_space':
    default:
      return const Color(0xFFFF00FF); // Original pink/magenta
  }
});
