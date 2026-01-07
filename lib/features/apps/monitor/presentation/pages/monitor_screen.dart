import 'package:flutter/material.dart';
import 'package:protfolio/core/theme/app_theme.dart';
import '../widgets/cpu_graph.dart';
import '../widgets/process_list.dart';

class MonitorScreen extends StatelessWidget {
  const MonitorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF111111),
      child: Column(
        children: [
          // Header / Graphs
          Container(
            height: 150,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[800]!)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CPU Usage', style: AppTheme.darkTheme.textTheme.bodyMedium),
                      const Expanded(child: CpuGraph(color: AppTheme.accent)),
                    ],
                  ),
                ),
                const VerticalDivider(color: Colors.grey),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Memory', style: AppTheme.darkTheme.textTheme.bodyMedium),
                      const Expanded(child: CpuGraph(color: Colors.cyanAccent)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Process List
          Expanded(child: const ProcessList()),
        ],
      ),
    );
  }
}
