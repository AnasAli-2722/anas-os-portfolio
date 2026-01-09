import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:protfolio/core/theme/app_theme.dart';
import 'package:protfolio/features/apps/monitor/presentation/pages/monitor_screen.dart';
import 'package:protfolio/features/apps/settings/presentation/pages/settings_screen.dart';
import 'package:protfolio/features/apps/store/presentation/pages/store_screen.dart';
import 'package:protfolio/features/apps/terminal/presentation/pages/terminal_screen.dart';
import 'package:protfolio/features/os/presentation/providers/wallpaper_provider.dart';
import 'package:protfolio/shared/widgets/digital_clock.dart';

class MobileLayout extends ConsumerWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallpaper = ref.watch(wallpaperProvider);

    return Scaffold(
      body: Stack(
        children: [
          // Wallpaper
          Positioned.fill(child: _buildWallpaper(wallpaper)),

          // Content
          SafeArea(
            child: Column(
              children: [
                const _StatusBar(),
                const SizedBox(height: 40),
                _buildClock(),
                const SizedBox(height: 40),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 4,
                    padding: const EdgeInsets.all(20),
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    children: [
                      // Social Links
                      _MobileAppIcon(
                        icon: FontAwesomeIcons.github,
                        label: 'GitHub',
                        color: Colors.white,
                        onTap: () =>
                            _launchURL('https://github.com/yourusername'),
                      ),
                      _MobileAppIcon(
                        icon: FontAwesomeIcons.linkedin,
                        label: 'LinkedIn',
                        color: const Color(0xFF0077B5),
                        onTap: () =>
                            _launchURL('https://linkedin.com/in/yourusername'),
                      ),
                      _MobileAppIcon(
                        icon: FontAwesomeIcons.twitter,
                        label: 'Twitter',
                        color: const Color(0xFF1DA1F2),
                        onTap: () =>
                            _launchURL('https://twitter.com/yourusername'),
                      ),
                      _MobileAppIcon(
                        icon: FontAwesomeIcons.envelope,
                        label: 'Email',
                        color: const Color(0xFFEA4335),
                        onTap: () =>
                            _launchURL('mailto:your.email@example.com'),
                      ),
                      _MobileAppIcon(
                        icon: FontAwesomeIcons.globe,
                        label: 'Website',
                        color: const Color(0xFF00D9FF),
                        onTap: () => _launchURL('https://yourwebsite.com'),
                      ),

                      // Applications
                      _MobileAppIcon(
                        icon: FontAwesomeIcons.briefcase,
                        label: 'Experience',
                        color: const Color(0xFFFFB800),
                        onTap: () => _openApp(
                          context,
                          'Experience',
                          _buildExperienceContent(),
                        ),
                      ),
                      _MobileAppIcon(
                        icon: FontAwesomeIcons.code,
                        label: 'Skills',
                        color: const Color(0xFF00FF87),
                        onTap: () =>
                            _openApp(context, 'Skills', _buildSkillsContent()),
                      ),
                      _MobileAppIcon(
                        icon: FontAwesomeIcons.folderOpen,
                        label: 'Projects',
                        color: const Color(0xFFFF6B6B),
                        onTap: () => _openApp(
                          context,
                          'Projects',
                          _buildProjectsContent(),
                        ),
                      ),
                      _MobileAppIcon(
                        icon: FontAwesomeIcons.user,
                        label: 'About',
                        color: const Color(0xFF9D4EDD),
                        onTap: () =>
                            _openApp(context, 'About Me', _buildAboutContent()),
                      ),
                      _MobileAppIcon(
                        icon: FontAwesomeIcons.graduationCap,
                        label: 'Education',
                        color: const Color(0xFF06FFA5),
                        onTap: () => _openApp(
                          context,
                          'Education',
                          _buildEducationContent(),
                        ),
                      ),
                      _MobileAppIcon(
                        icon: Icons.terminal,
                        label: 'Terminal',
                        color: Colors.black,
                        onTap: () => _openApp(
                          context,
                          'Terminal',
                          const TerminalScreen(),
                        ),
                      ),
                      _MobileAppIcon(
                        icon: Icons.shopping_bag,
                        label: 'Store',
                        color: Colors.blueAccent,
                        onTap: () =>
                            _openApp(context, 'Store', const StoreScreen()),
                      ),
                      _MobileAppIcon(
                        icon: Icons.monitor_heart,
                        label: 'Monitor',
                        color: Colors.greenAccent,
                        onTap: () =>
                            _openApp(context, 'System', const MonitorScreen()),
                      ),
                      _MobileAppIcon(
                        icon: Icons.settings,
                        label: 'Settings',
                        color: Colors.grey,
                        onTap: () => _openApp(
                          context,
                          'Settings',
                          const SettingsScreen(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _openApp(BuildContext context, String title, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(title, style: AppTheme.darkTheme.textTheme.bodyLarge),
            backgroundColor: AppTheme.background,
            iconTheme: const IconThemeData(color: AppTheme.accent),
          ),
          body: page,
        ),
      ),
    );
  }

  Widget _buildClock() {
    return DigitalClock(
      timeStyle: AppTheme.darkTheme.textTheme.displayLarge?.copyWith(
        fontSize: 60,
        fontWeight: FontWeight.w200,
        color: Colors.white.withOpacity(0.9),
      ),
      dateStyle: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
        color: Colors.white.withOpacity(0.7),
      ),
    );
  }

  Widget _buildExperienceContent() {
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
          ),
          const SizedBox(height: 16),
          _ExperienceItem(
            title: 'Flutter Developer',
            company: 'Startup Inc',
            period: '2021 - 2023',
            description: 'Developed cross-platform applications...',
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsContent() {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.black.withOpacity(0.3),
      child: ListView(
        children: [
          _SkillBar(skill: 'Flutter', level: 0.9),
          _SkillBar(skill: 'Dart', level: 0.85),
          _SkillBar(skill: 'Firebase', level: 0.8),
          _SkillBar(skill: 'UI/UX Design', level: 0.75),
          _SkillBar(skill: 'State Management', level: 0.85),
          _SkillBar(skill: 'REST APIs', level: 0.8),
        ],
      ),
    );
  }

  Widget _buildProjectsContent() {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.black.withOpacity(0.3),
      child: GridView.count(
        crossAxisCount: 1,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _ProjectCard(name: 'Portfolio OS', tech: 'Flutter'),
          _ProjectCard(name: 'E-Commerce App', tech: 'Flutter + Firebase'),
          _ProjectCard(name: 'Chat Application', tech: 'Flutter + WebSocket'),
          _ProjectCard(name: 'Weather App', tech: 'Flutter + API'),
        ],
      ),
    );
  }

  Widget _buildAboutContent() {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.black.withOpacity(0.3),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppTheme.accent,
              child: Icon(Icons.person, size: 50, color: Colors.white),
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

  Widget _buildEducationContent() {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.black.withOpacity(0.3),
      child: ListView(
        children: [
          _EducationItem(
            degree: 'Bachelor of Computer Science',
            institution: 'University of Engineering and Technology',
            year: '2018 - 2022',
          ),
          const SizedBox(height: 16),
          _EducationItem(
            degree: 'Flutter Development Certification',
            institution: 'Online Course',
            year: '2022',
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

class _StatusBar extends StatelessWidget {
  const _StatusBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          const Icon(Icons.signal_cellular_alt, color: Colors.white, size: 16),
          const SizedBox(width: 5),
          const Text('5G', style: TextStyle(color: Colors.white, fontSize: 12)),
          const Spacer(),
          const Icon(Icons.wifi, color: Colors.white, size: 16),
          const SizedBox(width: 10),
          const Icon(Icons.battery_full, color: Colors.white, size: 16),
        ],
      ),
    );
  }
}

class _MobileAppIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _MobileAppIcon({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withOpacity(0.5)),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Content Widget Classes
class _ExperienceItem extends StatelessWidget {
  final String title;
  final String company;
  final String period;
  final String description;

  const _ExperienceItem({
    required this.title,
    required this.company,
    required this.period,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
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

  const _SkillBar({required this.skill, required this.level});

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
              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.accent),
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

  const _ProjectCard({required this.name, required this.tech});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.folder, size: 40, color: AppTheme.accent),
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

  const _EducationItem({
    required this.degree,
    required this.institution,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
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
