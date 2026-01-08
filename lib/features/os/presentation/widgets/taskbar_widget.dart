import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaskbarWidget extends StatelessWidget {
  const TaskbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final timeString =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    return GlassmorphicContainer(
      width: MediaQuery.of(context).size.width,
      height: 60.h,
      borderRadius: 0,
      blur: 40,
      alignment: Alignment.center,
      border: 0,
      linearGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.8)],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.white.withOpacity(0.2), Colors.white.withOpacity(0.1)],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          children: [
            // Start Button
            _TaskbarButton(
              icon: FontAwesomeIcons.gripVertical,
              label: 'Apps',
              onTap: () {},
            ),

            const Spacer(),

            // System Tray
            Row(
              children: [
                Icon(FontAwesomeIcons.wifi, size: 16.sp, color: Colors.white70),
                SizedBox(width: 16.w),
                Icon(
                  FontAwesomeIcons.volumeHigh,
                  size: 16.sp,
                  color: Colors.white70,
                ),
                SizedBox(width: 16.w),
                Text(
                  timeString,
                  style: GoogleFonts.sourceCodePro(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskbarButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _TaskbarButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_TaskbarButton> createState() => _TaskbarButtonState();
}

class _TaskbarButtonState extends State<_TaskbarButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: _isHovered
                ? Colors.white.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Icon(widget.icon, size: 18.sp, color: Colors.white),
              SizedBox(width: 8.w),
              Text(
                widget.label,
                style: GoogleFonts.sourceCodePro(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
