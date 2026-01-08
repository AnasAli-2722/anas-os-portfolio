import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../domain/models/desktop_icon.dart';

class DesktopIconsData {
  static List<DesktopIcon> getIcons() {
    return [
      // Social Links
      DesktopIcon(
        id: 'github',
        label: 'GitHub',
        icon: FontAwesomeIcons.github,
        type: IconType.link,
        color: Colors.white,
        url: 'https://github.com/yourusername',
      ),
      DesktopIcon(
        id: 'linkedin',
        label: 'LinkedIn',
        icon: FontAwesomeIcons.linkedin,
        type: IconType.link,
        color: const Color(0xFF0077B5),
        url: 'https://linkedin.com/in/yourusername',
      ),
      DesktopIcon(
        id: 'twitter',
        label: 'Twitter',
        icon: FontAwesomeIcons.twitter,
        type: IconType.link,
        color: const Color(0xFF1DA1F2),
        url: 'https://twitter.com/yourusername',
      ),
      DesktopIcon(
        id: 'email',
        label: 'Email',
        icon: FontAwesomeIcons.envelope,
        type: IconType.link,
        color: const Color(0xFFEA4335),
        url: 'mailto:your.email@example.com',
      ),
      DesktopIcon(
        id: 'portfolio',
        label: 'Website',
        icon: FontAwesomeIcons.globe,
        type: IconType.link,
        color: const Color(0xFF00D9FF),
        url: 'https://yourwebsite.com',
      ),

      // Main Applications
      DesktopIcon(
        id: 'experience',
        label: 'Experience',
        icon: FontAwesomeIcons.briefcase,
        type: IconType.application,
        color: const Color(0xFFFFB800),
      ),
      DesktopIcon(
        id: 'skills',
        label: 'Skills',
        icon: FontAwesomeIcons.code,
        type: IconType.application,
        color: const Color(0xFF00FF87),
      ),
      DesktopIcon(
        id: 'projects',
        label: 'Projects',
        icon: FontAwesomeIcons.folderOpen,
        type: IconType.application,
        color: const Color(0xFFFF6B6B),
      ),
      DesktopIcon(
        id: 'about',
        label: 'About Me',
        icon: FontAwesomeIcons.user,
        type: IconType.application,
        color: const Color(0xFF9D4EDD),
      ),
      DesktopIcon(
        id: 'education',
        label: 'Education',
        icon: FontAwesomeIcons.graduationCap,
        type: IconType.application,
        color: const Color(0xFF06FFA5),
      ),
    ];
  }
}
