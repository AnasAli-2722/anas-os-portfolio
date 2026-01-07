import 'package:flutter/material.dart';
import 'package:protfolio/core/theme/app_theme.dart';
import '../../domain/models/project_model.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isInstalling = false;

  void _handleInstall() async {
    if (widget.project.isInstalled) return;

    setState(() => _isInstalling = true);
    // Simulate download
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _isInstalling = false;
        widget.project.isInstalled = true;
      });
      // TODO: Add to desktop/taskbar via provider
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.accent.withOpacity(0.1)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppTheme.accent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.app_shortcut, color: AppTheme.accent, size: 30),
          ),
          const SizedBox(height: 12),
          Text(
            widget.project.name,
            style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            widget.project.description,
            style: AppTheme.darkTheme.textTheme.bodyMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleInstall,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.project.isInstalled ? Colors.grey[800] : AppTheme.accent,
                foregroundColor: Colors.white,
              ),
              child: _isInstalling
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : Text(widget.project.isInstalled ? 'INSTALLED' : 'GET'),
            ),
          ),
        ],
      ),
    );
  }
}
