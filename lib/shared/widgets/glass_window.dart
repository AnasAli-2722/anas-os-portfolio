import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protfolio/core/theme/app_theme.dart';
import 'package:protfolio/features/os/domain/models/window_model.dart';
import 'package:protfolio/features/os/presentation/providers/window_provider.dart';

class GlassWindow extends ConsumerStatefulWidget {
  final WindowModel window;

  const GlassWindow({super.key, required this.window});

  @override
  ConsumerState<GlassWindow> createState() => _GlassWindowState();
}

class _GlassWindowState extends ConsumerState<GlassWindow> {
  Offset _localDragOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: _localDragOffset,
      child: GestureDetector(
        onTap: () {
          ref.read(windowProvider.notifier).bringToFront(widget.window.id);
        },
        onPanStart: (_) {
          ref.read(windowProvider.notifier).bringToFront(widget.window.id);
        },
        onPanUpdate: (details) {
          setState(() {
            _localDragOffset += details.delta;
          });
        },
        onPanEnd: (_) {
          final newPos = widget.window.position + _localDragOffset;
          ref.read(windowProvider.notifier).updateWindowPosition(widget.window.id, newPos);
          setState(() {
            _localDragOffset = Offset.zero;
          });
        },
        child: Container(
          width: widget.window.size.width,
          height: widget.window.size.height,
          decoration: BoxDecoration(
            color: AppTheme.surface.withOpacity(0.85),
            border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              // Title Bar
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppTheme.accent.withOpacity(0.1))),
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Row(
                  children: [
                    Text(
                      widget.window.title,
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.accent,
                      ),
                    ),
                    const Spacer(),
                    _WindowControl(
                      icon: Icons.minimize,
                      onTap: () => ref.read(windowProvider.notifier).toggleMinimize(widget.window.id),
                    ),
                    const SizedBox(width: 8),
                    _WindowControl(
                      icon: Icons.close,
                      onTap: () => ref.read(windowProvider.notifier).removeWindow(widget.window.id),
                      color: Colors.redAccent,
                    ),
                  ],
                ),
              ),
              // Content
              Expanded(
                child: widget.window.content,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WindowControl extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  const _WindowControl({required this.icon, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (color ?? AppTheme.textSecondary).withOpacity(0.2),
        ),
        child: Icon(icon, size: 12, color: color ?? AppTheme.textPrimary),
      ),
    );
  }
}
