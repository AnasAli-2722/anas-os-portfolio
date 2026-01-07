import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/window_model.dart';
import '../../../apps/monitor/presentation/pages/monitor_screen.dart';
import '../../../apps/terminal/presentation/pages/terminal_screen.dart';

class WindowNotifier extends Notifier<List<WindowModel>> {
  @override
  List<WindowModel> build() {
    return [
      WindowModel(
        id: 'terminal',
        title: 'Terminal',
        content: const TerminalScreen(),
        size: const Size(700, 500),
        position: const Offset(100, 100),
      ),
    ];
  }

  void addWindow(WindowModel window) {
    if (state.any((w) => w.id == window.id)) {
      bringToFront(window.id);
    } else {
      state = [...state, window];
    }
  }

  void removeWindow(String id) {
    state = state.where((w) => w.id != id).toList();
  }

  void bringToFront(String id) {
    final windowIndex = state.indexWhere((w) => w.id == id);
    if (windowIndex != -1) {
      final window = state[windowIndex];
      state = [...state..removeAt(windowIndex), window.copyWith(isMinimized: false)];
    }
  }

  void updateWindowPosition(String id, Offset newPosition) {
    state = [
      for (final window in state)
        if (window.id == id) window.copyWith(position: newPosition) else window
    ];
  }

  void toggleMinimize(String id) {
    state = [
      for (final window in state)
        if (window.id == id) window.copyWith(isMinimized: !window.isMinimized) else window
    ];
  }
}

final windowProvider = NotifierProvider<WindowNotifier, List<WindowModel>>(() {
  return WindowNotifier();
});
