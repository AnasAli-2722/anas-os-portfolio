import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class TerminalNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    return [
      'Welcome to Portfolio OS v1.0.0',
      'Type "help" for a list of commands.',
    ];
  }

  // Simple state machine for interactive commands
  String? _awaitingInputFor;

  void processCommand(String input) {
    // Echo the command
    state = [...state, '> $input'];

    if (_awaitingInputFor != null) {
      _handleInteractiveInput(input);
      return;
    }

    final command = input.trim().toLowerCase();

    switch (command) {
      case 'help':
        state = [
          ...state,
          'Available commands:',
          '  help         - Show this help message',
          '  whoami       - About the developer',
          '  about        - About me (alias)',
          '  aboutme      - About me (alias)',
          '  projects     - View my work',
          '  socials      - Connect with me',
          '  contact      - Send a message',
          '  contactme    - Send a message (alias)',
          '  clear        - Clear terminal',
          '  github       - Open GitHub',
          '  linkedin     - Open LinkedIn',
        ];
        break;
      case 'whoami':
      case 'about':
      case 'aboutme':
      case 'about me':
        state = [
          ...state,
          '---------------------------------------------------',
          '           MUHAMMAD ANAS ALI',
          '---------------------------------------------------',
          'Role:      Flutter Developer & CS Major',
          'Location:  Pakistan',
          'Mission:   Building pixel-perfect digital experiences.',
          '',
          'Skills:',
          '  • Mobile: Flutter, Dart',
          '  • Backend: Firebase, Node.js',
          '  • Languages: C++, Python, JavaScript',
          '  • UI/UX: Responsive Design, Animations',
          '  • Tools: Git, VS Code, Figma',
          '',
          'Interests:',
          '  • Cross-platform development',
          '  • Beautiful UI/UX design',
          '  • Open source contribution',
          '---------------------------------------------------',
        ];
        break;
      case 'socials':
        state = [
          ...state,
          'Connect with me:',
          '  • GitHub:    Type "github"',
          '  • LinkedIn:  Type "linkedin"',
          '  • Email:     Type "contact"',
        ];
        break;
      case 'github':
        _launchUrl('https://github.com/AnasAli-Dev'); // Placeholder
        break;
      case 'linkedin':
        _launchUrl('https://linkedin.com/in/anas-ali-dev'); // Placeholder
        break;
      case 'projects':
        state = [
          ...state,
          'Recent Projects:',
          '  • Portfolio OS:  Flutter Web OS simulation',
          '  • WifeyApp:      Relationship management app',
          '  • BentoGrid:     Modern UI showcase',
        ];
        break;
      case 'contact':
      case 'contactme':
      case 'contact me':
        state = [...state, 'Opening email client...'];
        _launchEmail();
        break;
      case 'clear':
        state = [];
        break;
      case 'mahnoor_2722':
        state = [...state, '<HEART> ❤️', '<LOVE> I love you Mahnoor'];
        break;
      case 'sudo hire_me':
        state = [
          ...state,
          'ACCESS GRANTED. INITIATING CELEBRATION PROTOCOL...',
        ];
        // Trigger global celebration event here (TODO)
        break;
      default:
        state = [
          ...state,
          'Command not found: $command. Type "help" for options.',
        ];
    }
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
      state = [...state, 'Opened: $urlString'];
    } else {
      state = [...state, 'Error: Could not launch $urlString'];
    }
  }

  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'usernameistaken444@gmail.com',
      query: 'subject=Portfolio Inquiry&body=Hi Muhammad Anas Ali,',
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      state = [
        ...state,
        'Error: Could not launch email client.',
        'Email: usernameistaken444@gmail.com',
      ];
    }
  }

  void _handleInteractiveInput(String input) {
    // Legacy interactive input removed in favor of direct mailto
  }
}

final terminalProvider = NotifierProvider<TerminalNotifier, List<String>>(() {
  return TerminalNotifier();
});
