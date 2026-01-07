import 'package:flutter/material.dart';
import 'package:protfolio/core/theme/app_theme.dart';

class ProcessList extends StatelessWidget {
  const ProcessList({super.key});

  final List<Map<String, String>> processes = const [
    {'name': 'flutter_engine.exe', 'status': 'Running', 'cpu': '12%'},
    {'name': 'dart_vm', 'status': 'Optimized', 'cpu': '8%'},
    {'name': 'firebase_service', 'status': 'Connected', 'cpu': '2%'},
    {'name': 'ui_renderer', 'status': 'High Priority', 'cpu': '15%'},
    {'name': 'creative_logic', 'status': 'Overclocked', 'cpu': '45%'},
    {'name': 'problem_solver', 'status': 'Active', 'cpu': '10%'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: processes.length,
      itemBuilder: (context, index) {
        final process = processes[index];
        return ListTile(
          leading: const Icon(Icons.memory, color: Colors.grey),
          title: Text(process['name']!, style: const TextStyle(color: Colors.white)),
          subtitle: Text(process['status']!, style: TextStyle(color: AppTheme.accent)),
          trailing: Text(process['cpu']!, style: const TextStyle(color: Colors.white)),
        );
      },
    );
  }
}
