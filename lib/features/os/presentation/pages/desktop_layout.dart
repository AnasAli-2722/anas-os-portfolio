import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:protfolio/core/theme/app_theme.dart';
import '../providers/window_provider.dart';
import 'package:protfolio/shared/widgets/glass_window.dart';
import '../widgets/taskbar.dart';
import '../providers/wallpaper_provider.dart';
import '../../domain/models/window_model.dart';
import '../../../apps/terminal/presentation/pages/terminal_screen.dart';

class DesktopLayout extends ConsumerWidget {
  const DesktopLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final windows = ref.watch(windowProvider);
    final wallpaper = ref.watch(wallpaperProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          // Background Wallpaper
          Positioned.fill(child: _buildWallpaper(wallpaper)),

          // Desktop Icons
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: _buildDesktopIcons(context, ref),
              ),
            ),
          ),

          // Windows Stack
          ...windows.map((window) {
            return Positioned(
              key: ValueKey(window.id),
              left: window.position.dx,
              top: window.position.dy,
              child: Offstage(
                offstage: window.isMinimized,
                child: RepaintBoundary(child: GlassWindow(window: window)),
              ),
            );
          }),

          // Taskbar
          const Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(child: Taskbar()),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopIcons(BuildContext context, WidgetRef ref) {
    return GridView.count(
      crossAxisCount: 6,
      mainAxisSpacing: 40,
      crossAxisSpacing: 40,
      childAspectRatio: 0.8,
      children: [
        // Social Links
        _DesktopIcon(
          icon: FontAwesomeIcons.github,
          label: 'GitHub',
          color: Colors.white,
          onTap: () => _launchURL('https://github.com/AnasAli-2722'),
        ),
        _DesktopIcon(
          icon: FontAwesomeIcons.linkedin,
          label: 'LinkedIn',
          color: const Color(0xFF0077B5),
          onTap: () => _launchURL('https://www.linkedin.com/in/anas-ali-dev'),
        ),
        _DesktopIcon(
          icon: FontAwesomeIcons.instagram,
          label: 'Instagram',
          color: const Color(0xFFE1306C),
          onTap: () => _launchURL('https://www.instagram.com/anasthatic_'),
        ),
        _DesktopIcon(
          icon: FontAwesomeIcons.envelope,
          label: 'Email',
          color: const Color(0xFFEA4335),
          onTap: () => _launchURL('mailto:24-cs-83@students.uettaxila.edu.pk'),
        ),

        // Applications
        _DesktopIcon(
          icon: FontAwesomeIcons.briefcase,
          label: 'Experience',
          color: const Color(0xFFFFB800),
          onTap: () => _openWindow(
            ref,
            'experience',
            'Experience',
            _buildExperienceContent(ref),
          ),
        ),
        _DesktopIcon(
          icon: FontAwesomeIcons.code,
          label: 'Skills',
          color: const Color(0xFF00FF87),
          onTap: () =>
              _openWindow(ref, 'skills', 'Skills', _buildSkillsContent(ref)),
        ),
        _DesktopIcon(
          icon: FontAwesomeIcons.folderOpen,
          label: 'Projects',
          color: const Color(0xFFFF6B6B),
          onTap: () => _openWindow(
            ref,
            'projects',
            'Projects',
            _buildProjectsContent(ref),
          ),
        ),
        _DesktopIcon(
          icon: FontAwesomeIcons.user,
          label: 'About Me',
          color: const Color(0xFF9D4EDD),
          onTap: () =>
              _openWindow(ref, 'about', 'About Me', _buildAboutContent(ref)),
        ),
        _DesktopIcon(
          icon: FontAwesomeIcons.graduationCap,
          label: 'Education',
          color: const Color(0xFF06FFA5),
          onTap: () => _openWindow(
            ref,
            'education',
            'Education',
            _buildEducationContent(ref),
          ),
        ),
        _DesktopIcon(
          icon: FontAwesomeIcons.terminal,
          label: 'Terminal',
          color: Colors.black87,
          onTap: () =>
              _openWindow(ref, 'terminal', 'Terminal', const TerminalScreen()),
        ),
      ],
    );
  }

  void _openWindow(WidgetRef ref, String id, String title, Widget content) {
    ref
        .read(windowProvider.notifier)
        .addWindow(
          WindowModel(
            id: id,
            title: title,
            content: content,
            size: const Size(700, 500),
            position: Offset(
              100 + (ref.read(windowProvider).length * 30.0),
              100 + (ref.read(windowProvider).length * 30.0),
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

  Widget _buildExperienceContent(WidgetRef ref) {
    final accentColor = ref.watch(accentColorProvider);
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.black.withOpacity(0.3),
      child: ListView(
        children: [
          _ExperienceItem(
            title: 'Senior Flutter Developer',
            company: 'Tech Company',
            period: '2023 - Present',
            description: 'Leading mobile app development projects...',
            accentColor: accentColor,
          ),
          const SizedBox(height: 16),
          _ExperienceItem(
            title: 'Flutter Developer',
            company: 'Startup Inc',
            period: '2021 - 2023',
            description: 'Developed cross-platform applications...',
            accentColor: accentColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsContent(WidgetRef ref) {
    final accentColor = ref.watch(accentColorProvider);
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.black.withOpacity(0.3),
      child: ListView(
        children: [
          _SkillBar(skill: 'Flutter', level: 0.9, accentColor: accentColor),
          _SkillBar(skill: 'Dart', level: 0.85, accentColor: accentColor),
          _SkillBar(skill: 'Firebase', level: 0.8, accentColor: accentColor),
          _SkillBar(
            skill: 'UI/UX Design',
            level: 0.75,
            accentColor: accentColor,
          ),
          _SkillBar(
            skill: 'State Management',
            level: 0.85,
            accentColor: accentColor,
          ),
          _SkillBar(skill: 'REST APIs', level: 0.8, accentColor: accentColor),
        ],
      ),
    );
  }

  Widget _buildProjectsContent(WidgetRef ref) {
    final accentColor = ref.watch(accentColorProvider);
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.black.withOpacity(0.3),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _ProjectCard(
            name: 'Portfolio OS',
            tech: 'Flutter',
            accentColor: accentColor,
          ),
          _ProjectCard(
            name: 'E-Commerce App',
            tech: 'Flutter + Firebase',
            accentColor: accentColor,
          ),
          _ProjectCard(
            name: 'Chat Application',
            tech: 'Flutter + WebSocket',
            accentColor: accentColor,
          ),
          _ProjectCard(
            name: 'Weather App',
            tech: 'Flutter + API',
            accentColor: accentColor,
          ),
        ],
      ),
    );
  }

  Widget _buildAboutContent(WidgetRef ref) {
    final accentColor = ref.watch(accentColorProvider);
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.black.withOpacity(0.3),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: accentColor,
              child: const Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text('Anas Ali', style: AppTheme.darkTheme.textTheme.displayMedium),
            const SizedBox(height: 8),
            Text(
              'Flutter Developer',
              style: AppTheme.darkTheme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            Text(
              'Passionate about creating beautiful and functional mobile applications. '
              'Experienced in Flutter, Dart, and modern app development practices.',
              style: AppTheme.darkTheme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationContent(WidgetRef ref) {
    final accentColor = ref.watch(accentColorProvider);
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.black.withOpacity(0.3),
      child: ListView(
        children: [
          _EducationItem(
            degree: 'Intermediate - ICS',
            institution: 'Kips College',
            year: '2021 - 2022',
            accentColor: accentColor,
          ),
          const SizedBox(height: 16),
          _EducationItem(
            degree: 'Bachelor of Computer Science',
            institution: 'University of Engineering and Technology',
            year: '2024 - Present',
            accentColor: accentColor,
          ),
        ],
      ),
    );
  }

  Widget _buildWallpaper(String id) {
    List<Color> colors;
    switch (id) {
      case 'cyber_red':
        colors = [const Color(0xFF200122), const Color(0xFF6f0000)];
        break;
      case 'void_black':
        colors = [const Color(0xFF000000), const Color(0xFF434343)];
        break;
      case 'neon_blue':
        colors = [const Color(0xFF000428), const Color(0xFF004e92)];
        break;
      case 'rose_gold':
        colors = [const Color(0xFF100007), const Color(0xFFB76E79)];
        break;
      case 'pink_dream':
        colors = [const Color(0xFF2E0219), const Color(0xFFFF007F)];
        break;
      case 'cotton_candy':
        colors = [const Color(0xFFFF99CC), const Color(0xFF99CCFF)];
        break;
      case 'deep_space':
      default:
        colors = [
          const Color(0xFF0F0C29),
          const Color(0xFF302B63),
          const Color(0xFF24243E),
        ];
        break;
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
    );
  }
}

class _DesktopIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _DesktopIcon({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  State<_DesktopIcon> createState() => _DesktopIconState();
}

class _DesktopIconState extends State<_DesktopIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isHovered ? 1.1 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(_isHovered ? 0.15 : 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _isHovered
                        ? widget.color.withOpacity(0.5)
                        : Colors.white.withOpacity(0.2),
                    width: 2,
                  ),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: widget.color.withOpacity(0.5),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ]
                      : null,
                ),
                child: Icon(widget.icon, size: 48, color: widget.color),
              ),
              const SizedBox(height: 8),
              Text(
                widget.label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  fontWeight: _isHovered ? FontWeight.bold : FontWeight.normal,
                  shadows: [
                    Shadow(color: Colors.black.withOpacity(0.8), blurRadius: 4),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExperienceItem extends StatelessWidget {
  final String title;
  final String company;
  final String period;
  final String description;
  final Color accentColor;

  const _ExperienceItem({
    required this.title,
    required this.company,
    required this.period,
    required this.accentColor,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accentColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$company • $period',
            style: AppTheme.darkTheme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillBar extends StatelessWidget {
  final String skill;
  final double level;
  final Color accentColor;

  const _SkillBar({
    required this.skill,
    required this.level,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(skill, style: AppTheme.darkTheme.textTheme.bodyMedium),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: level,
              minHeight: 8,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(accentColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final String name;
  final String tech;
  final Color accentColor;

  const _ProjectCard({
    required this.name,
    required this.tech,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accentColor.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder, size: 40, color: accentColor),
          const SizedBox(height: 12),
          Text(
            name,
            style: AppTheme.darkTheme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            tech,
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _EducationItem extends StatelessWidget {
  final String degree;
  final String institution;
  final String year;
  final Color accentColor;

  const _EducationItem({
    required this.degree,
    required this.institution,
    required this.year,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accentColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            degree,
            style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(institution, style: AppTheme.darkTheme.textTheme.bodyMedium),
          const SizedBox(height: 4),
          Text(
            year,
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
