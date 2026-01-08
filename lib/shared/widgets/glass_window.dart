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
  Size _localResizeSize = Size.zero;
  bool _isResizing = false;

  @override
  Widget build(BuildContext context) {
    final effectiveSize = _isResizing
        ? Size(
            widget.window.size.width + _localResizeSize.width,
            widget.window.size.height + _localResizeSize.height,
          )
        : widget.window.size;

    return Transform.translate(
      offset: _localDragOffset,
      child: GestureDetector(
        onTap: () {
          ref.read(windowProvider.notifier).bringToFront(widget.window.id);
        },
        child: Stack(
          children: [
            Container(
              width: effectiveSize.width,
              height: effectiveSize.height,
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
                  // Title Bar with drag functionality
                  GestureDetector(
                    onPanStart: (_) {
                      ref
                          .read(windowProvider.notifier)
                          .bringToFront(widget.window.id);
                    },
                    onPanUpdate: (details) {
                      setState(() {
                        _localDragOffset += details.delta;
                      });
                    },
                    onPanEnd: (_) {
                      final newPos = widget.window.position + _localDragOffset;
                      ref
                          .read(windowProvider.notifier)
                          .updateWindowPosition(widget.window.id, newPos);
                      setState(() {
                        _localDragOffset = Offset.zero;
                      });
                    },
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppTheme.accent.withOpacity(0.1),
                          ),
                        ),
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            widget.window.title,
                            style: AppTheme.darkTheme.textTheme.bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.accent,
                                ),
                          ),
                          const Spacer(),
                          _WindowControl(
                            icon: Icons.minimize,
                            onTap: () => ref
                                .read(windowProvider.notifier)
                                .toggleMinimize(widget.window.id),
                          ),
                          const SizedBox(width: 8),
                          _WindowControl(
                            icon: Icons.close,
                            onTap: () => ref
                                .read(windowProvider.notifier)
                                .removeWindow(widget.window.id),
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Content
                  Expanded(child: widget.window.content),
                ],
              ),
            ),
            // Resize Handle (bottom-right corner)
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onPanStart: (_) {
                  setState(() {
                    _isResizing = true;
                  });
                  ref
                      .read(windowProvider.notifier)
                      .bringToFront(widget.window.id);
                },
                onPanUpdate: (details) {
                  setState(() {
                    _localResizeSize = Size(
                      _localResizeSize.width + details.delta.dx,
                      _localResizeSize.height + details.delta.dy,
                    );
                  });
                },
                onPanEnd: (_) {
                  final newSize = Size(
                    (widget.window.size.width + _localResizeSize.width).clamp(
                      300.0,
                      1200.0,
                    ),
                    (widget.window.size.height + _localResizeSize.height).clamp(
                      200.0,
                      800.0,
                    ),
                  );
                  ref
                      .read(windowProvider.notifier)
                      .updateWindowSize(widget.window.id, newSize);
                  setState(() {
                    _localResizeSize = Size.zero;
                    _isResizing = false;
                  });
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeDownRight,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: AppTheme.accent.withOpacity(0.3),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Icon(
                      Icons.drag_handle,
                      size: 12,
                      color: AppTheme.accent,
                    ),
                  ),
                ),
              ),
            ),
          ],
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
