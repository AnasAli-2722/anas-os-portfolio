import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../os/presentation/pages/os_layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _loadingProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _simulateLoading();
  }

  Future<void> _simulateLoading() async {
    // Simulate resource loading
    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 20));
      if (mounted) {
        setState(() {
          _loadingProgress = i / 100;
        });
      }
    }

    // Navigate to OS Layout
    if (mounted) {
      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const OSLayout(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF0F0F1E),
              const Color(0xFF1A1A2E),
              const Color(0xFF16213E).withOpacity(0.8),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Animated background particles
            ...List.generate(20, (index) {
              return Positioned(
                left: (index * 100) % MediaQuery.of(context).size.width,
                top: (index * 50) % MediaQuery.of(context).size.height,
                child:
                    Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                        )
                        .animate(onPlay: (controller) => controller.repeat())
                        .fadeIn(duration: 1000.ms)
                        .fadeOut(duration: 1000.ms, delay: 1000.ms),
              );
            }),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo/Name
                  Text(
                        'ANAS ALI',
                        style: GoogleFonts.orbitron(
                          fontSize: 48.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 8,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: -0.3, end: 0, curve: Curves.easeOut),

                  SizedBox(height: 16.h),

                  // Subtitle
                  Text(
                        'PORTFOLIO OS',
                        style: GoogleFonts.sourceCodePro(
                          fontSize: 18.sp,
                          color: Colors.white70,
                          letterSpacing: 4,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 200.ms)
                      .slideY(begin: 0.3, end: 0),

                  SizedBox(height: 80.h),

                  // Loading bar
                  SizedBox(
                        width: 300.w,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: _loadingProgress,
                                minHeight: 6.h,
                                backgroundColor: Colors.white.withOpacity(0.1),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Color(0xFF00D9FF),
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              '${(_loadingProgress * 100).toInt()}%',
                              style: GoogleFonts.sourceCodePro(
                                fontSize: 14.sp,
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 400.ms)
                      .slideY(begin: 0.3, end: 0),
                ],
              ),
            ),

            // Version info at bottom
            Positioned(
              bottom: 40.h,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'v1.0.0 | Powered by Flutter',
                  style: GoogleFonts.sourceCodePro(
                    fontSize: 12.sp,
                    color: Colors.white30,
                  ),
                ),
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 600.ms),
          ],
        ),
      ),
    );
  }
}
