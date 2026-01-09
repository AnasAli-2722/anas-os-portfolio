import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../logic/terminal_provider.dart';
import '../../../../os/presentation/providers/wallpaper_provider.dart';

class TerminalScreen extends ConsumerStatefulWidget {
  const TerminalScreen({super.key});

  @override
  ConsumerState<TerminalScreen> createState() => _TerminalScreenState();
}

class _TerminalScreenState extends ConsumerState<TerminalScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Auto-focus the input
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(terminalProvider);
    final accentColor = ref.watch(accentColorProvider);

    // Auto-scroll on new history
    ref.listen(terminalProvider, (previous, next) {
      _scrollToBottom();
    });

    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: history.length,
              itemBuilder: (context, index) {
                final line = history[index];

                if (line.startsWith('<HEART>')) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      line.replaceAll('<HEART> ', ''),
                      style: const TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (line.startsWith('<LOVE>')) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      line.replaceAll('<LOVE> ', ''),
                      style: GoogleFonts.dancingScript(
                        // Romantic font
                        color: Colors.pinkAccent,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    line,
                    style: GoogleFonts.firaCode(
                      color: line.startsWith('>')
                          ? accentColor
                          : Colors.greenAccent,
                      fontSize: 14,
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(color: Colors.grey),
          Row(
            children: [
              Text(
                '> ',
                style: GoogleFonts.firaCode(
                  color: accentColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  style: GoogleFonts.firaCode(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      ref.read(terminalProvider.notifier).processCommand(value);
                      _controller.clear();
                      _focusNode.requestFocus();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
