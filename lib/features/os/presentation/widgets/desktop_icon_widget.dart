import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../../domain/models/desktop_icon.dart';

class DesktopIconWidget extends StatefulWidget {
  final DesktopIcon icon;
  final VoidCallback? onTap;
  final bool compact;

  const DesktopIconWidget({
    super.key,
    required this.icon,
    this.onTap,
    this.compact = false,
  });

  @override
  State<DesktopIconWidget> createState() => _DesktopIconWidgetState();
}

class _DesktopIconWidgetState extends State<DesktopIconWidget> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final iconSize = widget.compact ? 32.sp : 48.sp;
    final labelSize = widget.compact ? 11.sp : 13.sp;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onTap?.call();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedScale(
          scale: _isPressed ? 0.95 : (_isHovered ? 1.05 : 1.0),
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon Container with glassmorphism effect
              Container(
                    width: iconSize * 1.8,
                    height: iconSize * 1.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: _isHovered
                          ? [
                              BoxShadow(
                                color: (widget.icon.color ?? Colors.blue)
                                    .withOpacity(0.5),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: GlassmorphicContainer(
                      width: iconSize * 1.8,
                      height: iconSize * 1.8,
                      borderRadius: 16.r,
                      blur: 20,
                      alignment: Alignment.center,
                      border: 2,
                      linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.05),
                        ],
                      ),
                      borderGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.5),
                          Colors.white.withOpacity(0.2),
                        ],
                      ),
                      child: Icon(
                        widget.icon.icon,
                        size: iconSize,
                        color: widget.icon.color ?? Colors.white,
                      ),
                    ),
                  )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(
                    duration: 2000.ms,
                    color: Colors.white.withOpacity(0.1),
                  ),

              SizedBox(height: 8.h),

              // Label with shadow for better readability
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: _isHovered
                    ? BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8.r),
                      )
                    : null,
                child: Text(
                  widget.icon.label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.sourceCodePro(
                    fontSize: labelSize,
                    color: Colors.white,
                    fontWeight: _isHovered
                        ? FontWeight.w600
                        : FontWeight.normal,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.8),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
