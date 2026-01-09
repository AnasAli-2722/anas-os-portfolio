class ProjectModel {
  final String id;
  final String name;
  final String description;
  final String iconUrl;
  final List<String> techStack;
  final String? liveUrl;
  bool isInstalled;

  ProjectModel({
    required this.id,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.techStack,
    this.liveUrl,
    this.isInstalled = false,
  });
}
