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
