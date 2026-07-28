import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:async';

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
      home: const AnimatedSplashScreen(
        nextScreen: MainNavigationHub(),
      ),
    );
  }
}

class AnimatedSplashScreen extends StatefulWidget {
  final Widget nextScreen;
  const AnimatedSplashScreen({super.key, required this.nextScreen});

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _textOpacity;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _textOpacity = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeIn)),
        weight: 40.0,
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(1.0),
        weight: 30.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0).chain(CurveTween(curve: Curves.easeOut)),
        weight: 30.0,
      ),
    ]).animate(_animationController);

    _animationController.forward();

    Timer(const Duration(milliseconds: 2400), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => widget.nextScreen,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: FadeTransition(
          opacity: _textOpacity,
          child: Text(
            'REACNAR',
            style: GoogleFonts.robotoMono(
              color: primaryColor,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.25,
            ),
          ),
        ),
      ),
    );
  }
}
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