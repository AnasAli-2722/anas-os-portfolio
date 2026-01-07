import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme/app_theme.dart';
import 'features/os/presentation/pages/os_layout.dart';
import 'features/os/presentation/providers/wallpaper_provider.dart';
// import 'firebase_options.dart'; // Uncomment when firebase_options.dart is available

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // ); // Uncomment when firebase is configured
  
  runApp(ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
    ],
    child: const PortfolioOS(),
  ));
}

class PortfolioOS extends StatelessWidget {
  const PortfolioOS({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anas Ali | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const OSLayout(),
    );
  }
}
