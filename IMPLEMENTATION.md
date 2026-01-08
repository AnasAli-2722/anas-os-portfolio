# Portfolio OS - Modern Portfolio Website

A beautiful, interactive portfolio application built with Flutter, designed to mimic an operating system interface.

## 🌟 Features Implemented

### ✨ Animated Splash Screen
- Beautiful loading animation with progress bar
- Smooth fade transitions
- Animated particles background
- Custom fonts using Google Fonts (Orbitron & Source Code Pro)

### 🎨 Modern Desktop Interface
- **Responsive Design**: Works on both desktop and mobile devices
- **Glass Morphism UI**: Beautiful frosted glass effects on icons and taskbar
- **Smooth Animations**: Hover effects, scale animations, and transitions
- **Grid Layout**: Organized icon grid that adapts to screen size

### 🔗 Social Links (Desktop Icons)
All your social links are now available as clickable icons on the home screen:
- GitHub
- LinkedIn
- Twitter
- Email
- Personal Website

### 📱 Application Icons
Interactive application icons for your portfolio sections:
- **Experience** - Your work history (⚠️ Coming Soon)
- **Skills** - Your technical skills (⚠️ Coming Soon)
- **Projects** - Your portfolio projects (⚠️ Coming Soon)
- **About Me** - Personal information (⚠️ Coming Soon)
- **Education** - Academic background (⚠️ Coming Soon)

### 🎯 Advanced Features
- **Flutter Impeller Engine**: Uses the latest rendering engine for better performance
- **ScreenUtil**: Responsive sizing across all devices
- **Shimmer Effects**: Subtle shimmer animations on icons
- **Custom Taskbar**: Windows-style taskbar with system tray
- **Grid Background**: Subtle grid pattern on wallpaper
- **Smooth Transitions**: Page route transitions with fade effects

## 🛠️ Technologies Used

- **Flutter 3.8.1+**
- **flutter_riverpod** - State management
- **flutter_animate** - Smooth animations
- **glassmorphism** - Frosted glass UI effects
- **flutter_screenutil** - Responsive design
- **google_fonts** - Custom typography
- **font_awesome_flutter** - Icon library
- **url_launcher** - Open external links
- **lottie** - Animation support
- **shimmer** - Shimmer effects

## 📂 Project Structure

```
lib/
├── core/
│   └── theme/
│       └── app_theme.dart          # App theme configuration
├── features/
│   ├── splash/
│   │   └── presentation/
│   │       └── pages/
│   │           └── splash_screen.dart    # Animated splash screen
│   └── os/
│       ├── domain/
│       │   └── models/
│       │       └── desktop_icon.dart     # Icon data model
│       ├── data/
│       │   └── desktop_icons_data.dart   # Icon configuration
│       └── presentation/
│           ├── pages/
│           │   └── os_layout.dart        # Main OS layout
│           ├── widgets/
│           │   ├── desktop_icon_widget.dart
│           │   ├── taskbar_widget.dart
│           │   └── wallpaper_widget.dart
│           └── providers/
│               └── wallpaper_provider.dart
└── main.dart
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Chrome/Edge for web development
- Any IDE (VS Code, Android Studio, etc.)

### Installation

1. Clone the repository
```bash
git clone <your-repo-url>
cd protfolio
```

2. Install dependencies
```bash
flutter pub get
```

3. Update your social links in `lib/features/os/data/desktop_icons_data.dart`

4. Run the app
```bash
flutter run -d chrome      # For web
flutter run -d windows     # For Windows
flutter run                # For mobile/emulator
```

## ⚙️ Configuration

### Update Social Links
Edit `lib/features/os/data/desktop_icons_data.dart` and replace the placeholder URLs:

```dart
url: 'https://github.com/yourusername',     // Your GitHub
url: 'https://linkedin.com/in/yourusername', // Your LinkedIn
url: 'mailto:your.email@example.com',       // Your Email
```

### Customize Colors
Edit `lib/core/theme/app_theme.dart` to change the color scheme.

### Add Your Name
Update the splash screen name in `lib/features/splash/presentation/pages/splash_screen.dart`:
```dart
Text('YOUR NAME')
```

## 🎨 Color Scheme

- **Primary Background**: `#0A0E27` → `#1A1A2E` → `#16213E` (Gradient)
- **Accent**: `#00D9FF` (Cyan Blue)
- **Icon Colors**: Custom per icon (GitHub: White, LinkedIn: Blue, etc.)

## 📱 Responsive Breakpoints

- **Desktop**: > 768px width (6-column grid)
- **Mobile**: ≤ 768px width (4-column grid)

## 🔄 Next Steps (To Be Implemented)

1. **Experience Window** - Display work history in an OS-style window
2. **Skills Window** - Showcase technical skills with progress bars
3. **Projects Window** - Portfolio gallery with project details
4. **About Me Window** - Personal bio and information
5. **Education Window** - Academic achievements
6. **Window Management** - Drag, resize, minimize, maximize windows
7. **Theme Switcher** - Light/Dark mode toggle
8. **Wallpaper Customization** - Dynamic wallpaper selection

## 📝 Notes

- All icons are functional and clickable
- Social links open in external browser/app
- Application icons show "Coming Soon" dialog (to be replaced with actual windows)
- The app uses Flutter's Impeller rendering engine for improved performance
- All animations are optimized for 60 FPS

## 🤝 Contributing

This is a personal portfolio project, but suggestions and feedback are welcome!

## 📄 License

MIT License - Feel free to use this as inspiration for your own portfolio!

---

**Built with ❤️ using Flutter**
