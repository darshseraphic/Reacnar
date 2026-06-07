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
      home: const MainNavigationHub(),
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