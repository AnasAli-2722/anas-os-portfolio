import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:protfolio/core/theme/app_theme.dart';
import '../../domain/models/window_model.dart';
import '../providers/window_provider.dart';
import '../../../apps/terminal/presentation/pages/terminal_screen.dart';
import '../../../apps/store/presentation/pages/store_screen.dart';
import '../../../apps/monitor/presentation/pages/monitor_screen.dart';
import '../../../apps/settings/presentation/pages/settings_screen.dart';
import '../../../../shared/widgets/digital_clock.dart';

class Taskbar extends ConsumerWidget {
  const Taskbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Social Links Section
              _TaskbarIcon(
                icon: FontAwesomeIcons.instagram,
                label: 'Instagram',
                color: const Color(0xFFE1306C),
                onTap: () =>
                    _launchURL('https://www.instagram.com/anasthatic_'),
              ),
              const SizedBox(width: 12),
              _TaskbarIcon(
                icon: FontAwesomeIcons.linkedin,
                label: 'LinkedIn',
                color: const Color(0xFF0077B5),
                onTap: () =>
                    _launchURL('https://www.linkedin.com/in/anas-ali-dev'),
              ),
              const SizedBox(width: 12),
              _TaskbarIcon(
                icon: FontAwesomeIcons.envelope,
                label: 'Email',
                color: const Color(0xFFEA4335),
                onTap: () =>
                    _launchURL('mailto:24-cs-83@students.uettaxila.edu.pk'),
              ),
              const SizedBox(width: 12),
              _TaskbarIcon(
                icon: FontAwesomeIcons.briefcase,
                label: 'Hire Me',
                color: const Color(0xFF00FF87),
                onTap: () => _launchURL('https://yourwebsite.com/hire'),
              ),
              const SizedBox(width: 16),
              Container(
                width: 1,
                height: 40,
                color: Colors.white.withOpacity(0.2),
              ),
              const SizedBox(width: 16),

              // App Icons
              _TaskbarIcon(
                icon: Icons.terminal,
                label: 'Terminal',
                onTap: () {
                  ref
                      .read(windowProvider.notifier)
                      .addWindow(
                        WindowModel(
                          id: 'terminal',
                          title: 'Terminal',
                          content: const TerminalScreen(),
                          size: const Size(700, 500),
                        ),
                      );
                },
              ),
              const SizedBox(width: 12),
              _TaskbarIcon(
                icon: Icons.store,
                label: 'App Store',
                onTap: () {
                  ref
                      .read(windowProvider.notifier)
                      .addWindow(
                        WindowModel(
                          id: 'store',
                          title: 'App Store',
                          content: const StoreScreen(),
                          size: const Size(900, 600),
                        ),
                      );
                },
              ),
              const SizedBox(width: 12),
              _TaskbarIcon(
                icon: Icons.monitor_heart,
                label: 'System',
                onTap: () {
                  ref
                      .read(windowProvider.notifier)
                      .addWindow(
                        WindowModel(
                          id: 'monitor',
                          title: 'System Monitor',
                          content: const MonitorScreen(),
                          size: const Size(600, 400),
                        ),
                      );
                },
              ),
              const SizedBox(width: 12),
              _TaskbarIcon(
                icon: Icons.settings,
                label: 'Settings',
                onTap: () {
                  ref
                      .read(windowProvider.notifier)
                      .addWindow(
                        WindowModel(
                          id: 'settings',
                          title: 'Settings',
                          content: const SettingsScreen(),
                          size: const Size(500, 400),
                        ),
                      );
                },
              ),
              const SizedBox(width: 16),
              Container(
                width: 1,
                height: 40,
                color: Colors.white.withOpacity(0.2),
              ),
              const SizedBox(width: 16),
              DigitalClock(
                crossAxisAlignment: CrossAxisAlignment.end,
                timeStyle: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                dateStyle: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _TaskbarIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _TaskbarIcon({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  State<_TaskbarIcon> createState() => _TaskbarIconState();
}

class _TaskbarIconState extends State<_TaskbarIcon> {
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
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _isHovered
                ? (widget.color ?? AppTheme.accent).withOpacity(0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: _isHovered
                ? Border.all(color: widget.color ?? AppTheme.accent)
                : Border.all(color: Colors.transparent),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: _isHovered
                    ? (widget.color ?? AppTheme.accent)
                    : Colors.white,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
