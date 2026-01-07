import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protfolio/core/theme/app_theme.dart';
import '../../domain/models/project_model.dart';
import '../widgets/project_card.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  // Mock Data
  final List<ProjectModel> projects = [
    ProjectModel(
      id: '1',
      name: 'Cricket Jersey Designer',
      description: 'A 3D jersey customization tool built with Flutter.',
      iconUrl: 'assets/icons/jersey.png',
      techStack: ['Flutter', 'Three.js', 'Firebase'],
    ),
    ProjectModel(
      id: '2',
      name: 'Chat App',
      description: 'Real-time messaging with end-to-end encryption.',
      iconUrl: 'assets/icons/chat.png',
      techStack: ['Flutter', 'WebSockets', 'Node.js'],
    ),
    ProjectModel(
      id: '3',
      name: 'Portfolio OS',
      description: 'The website you are currently using!',
      iconUrl: 'assets/icons/os.png',
      techStack: ['Flutter Web', 'Riverpod', 'Rive'],
      isInstalled: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Featured Projects',
              style: AppTheme.darkTheme.textTheme.displayMedium,
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return ProjectCard(project: projects[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
