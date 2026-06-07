import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/react/reactscreen.dart';
import 'features/analytics/analyticscreen.dart';
import 'features/settings/settingscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('reacnar_settings');
  await Hive.openBox<Map>('reacnar_logs');
  runApp(const ReacnarApp());
}

class ReacnarApp extends StatefulWidget {
  const ReacnarApp({super.key});

  static _ReacnarAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_ReacnarAppState>()!;

  @override
  State<ReacnarApp> createState() => _ReacnarAppState();
}

class _ReacnarAppState extends State<ReacnarApp> {
  String _themeMode = 'DARK';

  @override
  void initState() {
    super.initState();
    _themeMode = Hive.box('reacnar_settings').get('theme_mode', defaultValue: 'DARK');
  }

  void updateTheme(String newTheme) {
    setState(() => _themeMode = newTheme);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reacnar',
      debugShowCheckedModeBanner: false,
      theme: _themeMode == 'DARK'
          ? ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFFFFFFF),
        scaffoldBackgroundColor: Colors.black,
      )
          : ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
      ),
      // Swap out the direct layout call for your custom Animated Splash pipeline
      home: const AnimatedSplashScreen(
        nextScreen: MainNavigationHub(),
      ),
    );
  }
}

// =========================================================================
// CUSTOM EMBEDDED ANIMATED SPLASH SCREEN WIDGET
// =========================================================================
class AnimatedSplashScreen extends StatefulWidget {
  final Widget nextScreen;
  const AnimatedSplashScreen({super.key, required this.nextScreen});

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200), // Timing duration of logo fade animation
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    _fadeController.forward();

    // Hold screen state for 2.5 seconds total runtime before routing out to core app
    Timer(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => widget.nextScreen,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Displaying your custom assets file logo directly centered
              Image.asset(
                'assets/logo.png',
                width: 100,          // Changed from 110 to 100 to match your other project
                height: 100,         // Changed from 110 to 100 to match your other project
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.blur_on, size: 100, color: primaryColor); // Also adjusted fallback size to 100
                },
              ),
              const SizedBox(height: 24),
              Text(
                'REACNAR',
                style: GoogleFonts.robotoMono(
                  color: primaryColor.withOpacity(0.6),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================================================
// REMAINDER UNCHANGED CORE SYSTEM NAVIGATION INTERFACE
// =========================================================================
class MainNavigationHub extends StatefulWidget {
  const MainNavigationHub({super.key});

  @override
  State<MainNavigationHub> createState() => _MainNavigationHubState();
}

class _MainNavigationHubState extends State<MainNavigationHub> {
  int _activeTab = 0;

  final List<Widget> _screens = [
    const ReactScreen(),
    const AnalyticsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final unselectedColor = primaryColor.withOpacity(0.3);
    final isDark = Theme.of(context).scaffoldBackgroundColor == Colors.black;
    final borderLine = isDark ? const Color(0xFF1F1F1F) : const Color(0xFFE5E5E5);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _screens[_activeTab]),
            Container(height: 0.8, color: borderLine),
            Container(
              height: 60,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Row(
                children: [
                  _buildTabButton(0, 'ARENA', primaryColor, unselectedColor),
                  Container(width: 0.8, color: borderLine),
                  _buildTabButton(1, 'ANALYTICS', primaryColor, unselectedColor),
                  Container(width: 0.8, color: borderLine),
                  _buildTabButton(2, 'SETTINGS', primaryColor, unselectedColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(int index, String label, Color primary, Color unselected) {
    final bool isActive = _activeTab == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _activeTab = index),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            label,
            style: GoogleFonts.robotoMono(
              color: isActive ? primary : unselected,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.08,
            ),
          ),
        ),
      ),
    );
  }
}