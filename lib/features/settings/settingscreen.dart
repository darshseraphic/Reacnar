import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../main.dart';

class SquareSliderThumbShape extends SliderComponentShape {
  final double thumbSize;
  const SquareSliderThumbShape({this.thumbSize = 8.0});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size(thumbSize, thumbSize);

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    context.canvas.drawRect(
      Rect.fromCenter(center: center, width: thumbSize, height: thumbSize),
      Paint()
        ..color = sliderTheme.thumbColor ?? Colors.white
        ..style = PaintingStyle.fill,
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late Box _settingsBox;
  late bool _haptics;
  late bool _antiCheat;
  late double _minDelay;
  late double _maxDelay;
  late String _activeTheme;

  @override
  void initState() {
    super.initState();
    _settingsBox = Hive.box('reacnar_settings');
    _haptics = _settingsBox.get('haptics_enabled', defaultValue: true);
    _antiCheat = _settingsBox.get('anti_cheat', defaultValue: true);
    _minDelay = _settingsBox.get('min_delay', defaultValue: 1.0);
    _maxDelay = _settingsBox.get('max_delay', defaultValue: 10.0);
    _activeTheme = _settingsBox.get('theme_mode', defaultValue: 'DARK');
  }

  void _updateThemeSelection(String value) {
    setState(() => _activeTheme = value);
    _settingsBox.put('theme_mode', value);
    ReacnarApp.of(context).updateTheme(value);
  }

  Future<void> _redirectExternalUrl(String targetUrl) async {
    try {
      final Uri uri = Uri.parse(targetUrl);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      try {
        await launchUrl(Uri.parse(targetUrl), mode: LaunchMode.platformDefault);
      } catch (_) {}
    }
  }

  void _pushSlidingSubTab(BuildContext context, String panelTitle, String informationBody) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            SlidingInformationView(title: panelTitle, content: informationBody),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeInOutCubic)),
            ),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final isDark = Theme.of(context).scaffoldBackgroundColor == Colors.black;
    final borderLine = isDark ? const Color(0xFF1F1F1F) : const Color(0xFFE5E5E5);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('HARDWARE TUNING INTERFACE',
              style: GoogleFonts.robotoMono(
                  color: primaryColor, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: -0.02)),
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                _buildToggleRow('TACTILE HAPTIC CONFIRMATION', _haptics, (val) {
                  setState(() => _haptics = val);
                  _settingsBox.put('haptics_enabled', val);
                }, primaryColor, borderLine),
                _buildToggleRow('ANTI-CHEAT PENALTY GLOW', _antiCheat, (val) {
                  setState(() => _antiCheat = val);
                  _settingsBox.put('anti_cheat', val);
                }, primaryColor, borderLine),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('MIN EXPERIMENTAL DELAY',
                        style: GoogleFonts.robotoMono(color: primaryColor, fontSize: 10, fontWeight: FontWeight.bold)),
                    Text('${_minDelay.toStringAsFixed(1)}s',
                        style: GoogleFonts.robotoMono(color: primaryColor, fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 6),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 1.0,
                    activeTrackColor: primaryColor,
                    inactiveTrackColor: primaryColor.withOpacity(0.15),
                    thumbColor: primaryColor,
                    thumbShape: const SquareSliderThumbShape(thumbSize: 8.0),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 0.0),
                  ),
                  child: Slider(
                    value: _minDelay,
                    min: 0.1,
                    max: 10.0,
                    onChanged: (val) {
                      if (val <= _maxDelay) {
                        setState(() => _minDelay = val);
                        _settingsBox.put('min_delay', val);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('MAX EXPERIMENTAL DELAY',
                        style: GoogleFonts.robotoMono(color: primaryColor, fontSize: 10, fontWeight: FontWeight.bold)),
                    Text('${_maxDelay.toStringAsFixed(1)}s',
                        style: GoogleFonts.robotoMono(color: primaryColor, fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 6),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 1.0,
                    activeTrackColor: primaryColor,
                    inactiveTrackColor: primaryColor.withOpacity(0.15),
                    thumbColor: primaryColor,
                    thumbShape: const SquareSliderThumbShape(thumbSize: 8.0),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 0.0),
                  ),
                  child: Slider(
                    value: _maxDelay,
                    min: 0.1,
                    max: 10.0,
                    onChanged: (val) {
                      if (val >= _minDelay) {
                        setState(() => _maxDelay = val);
                        _settingsBox.put('max_delay', val);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Text('DISPLAY THEME MATRIX',
                    style: GoogleFonts.robotoMono(color: primaryColor, fontSize: 10, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _buildThemeSelectorTile('DARK TERMINAL MODE', 'DARK', _activeTheme, primaryColor),
                _buildThemeSelectorTile('LIGHT FIELD MODE', 'LIGHT', _activeTheme, primaryColor),
                const SizedBox(height: 24),
                _buildNavigationLinkTile('SYSTEM OPERATION GUIDE', () {
                  _pushSlidingSubTab(context, 'OPERATION GUIDE', _guideContent);
                }, primaryColor, borderLine),
                _buildNavigationLinkTile('PRIVACY POLICY PROTOCOL', () {
                  _pushSlidingSubTab(context, 'PRIVACY POLICY', _privacyContent);
                }, primaryColor, borderLine),
                _buildNavigationLinkTile('OFFICIAL WEB PLATFORM', () {
                  _redirectExternalUrl('https://reacnar.lovable.app');
                }, primaryColor, borderLine),
                _buildNavigationLinkTile('SUBMIT CENTRAL FEEDBACK', () {
                  _redirectExternalUrl('https://reacnar.lovable.app/contact');
                }, primaryColor, borderLine),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleRow(String label, bool state, ValueChanged<bool> onChange, Color primary, Color line) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: line, width: 0.8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.robotoMono(color: primary, fontSize: 10, fontWeight: FontWeight.bold)),
          GestureDetector(
            onTap: () => onChange(!state),
            child: Container(
              width: 36,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: primary, width: 1.2),
              ),
              padding: const EdgeInsets.all(2),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 120),
                alignment: state ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(width: 12, height: 12, color: state ? primary : primary.withOpacity(0.3)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeSelectorTile(String title, String code, String current, Color primary) {
    final bool isSelected = current == code;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isSelected ? primary.withOpacity(0.06) : Colors.transparent,
        border: Border.all(color: isSelected ? primary : primary.withOpacity(0.15), width: 1.2),
      ),
      child: InkWell(
        onTap: () => _updateThemeSelection(code),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: GoogleFonts.robotoMono(color: primary, fontSize: 11, fontWeight: FontWeight.bold)),
              if (isSelected)
                Text('[ACTIVE]', style: GoogleFonts.robotoMono(color: primary, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationLinkTile(String label, VoidCallback actionTap, Color primary, Color line) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: line, width: 0.8))),
      child: InkWell(
        onTap: actionTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: GoogleFonts.robotoMono(color: primary, fontSize: 11, fontWeight: FontWeight.w600)),
              Text('//', style: GoogleFonts.robotoMono(color: primary.withOpacity(0.25), fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Static content ────────────────────────────────────────────────────────────

const String _guideContent = '''
**REACNAR OPERATION GUIDE**

**OVERVIEW**
Reacnar is a precision reflex training platform designed to measure and improve your biological reaction time through three distinct training modes.

**ARENA MODES**

**NORMAL MODE**
The standard reaction test. Tap the screen to begin. Wait for the circle to activate (turn green), then tap as fast as possible. Your response time is recorded in milliseconds. Tapping before the signal triggers a false start penalty if Anti-Cheat is enabled.

**BURST MODE**
A rapid-fire sequence trainer. After initiating, a cluster of 3–5 signals fires in quick succession with randomised micro-intervals between each. React to every tick. Your final score is the mean average across all ticks in the cluster, rewarding consistency over individual speed.

**CLICK MODE**
A 60-second click speed endurance trial. Tap as many times as possible before the timer expires. Your total tap count is recorded as your score. Higher is better.

**SETTINGS**

**TACTILE HAPTIC CONFIRMATION**
Enables vibration feedback on signal trigger and response registration.

**ANTI-CHEAT PENALTY GLOW**
When enabled, tapping before the signal fires locks the arena in a red penalty state. You must tap again to reset and retry.

**MIN / MAX EXPERIMENTAL DELAY**
Controls the randomised wait window before each signal fires. A wider range increases unpredictability. A narrow range (e.g. both set to 2.0s) creates a fixed delay for rhythm-based training.

**TELEMETRY DASHBOARD**
The Analytics tab tracks all sessions per mode. The bar chart shows your average performance broken down by day of the week. Stats include your personal record, all-time average, and false start count.

**PURGE**
Permanently deletes all stored records across every mode. This action cannot be undone.
''';

const String _privacyContent = '''
**REACNAR PRIVACY POLICY**

**Last updated: June 2026**

**DATA COLLECTION**
Reacnar does not collect, transmit, or share any personal data. The application operates entirely on-device.

**LOCAL STORAGE**
All training records, session telemetry, and settings are stored locally on your device using Hive, a lightweight embedded database. No data leaves your device at any time.

**NO ACCOUNTS REQUIRED**
Reacnar requires no account creation, login, or registration of any kind. No email address, name, or identifying information is ever requested or stored.

**NO NETWORK REQUESTS**
Reacnar makes no network requests during normal operation. The only external links present in the app are optional redirects to the official web platform and feedback form, which only activate on explicit user tap.

**NO ANALYTICS OR TRACKING**
Reacnar does not integrate any third-party analytics, advertising SDKs, crash reporting services, or tracking frameworks. Your usage patterns are never observed or recorded externally.

**NO THIRD-PARTY DATA SHARING**
Because no data is collected, no data is shared with any third party under any circumstances.

**DATA DELETION**
You may permanently delete all locally stored telemetry at any time using the PURGE ALL SYSTEM METRICS function in the Analytics tab. Uninstalling the application removes all associated data from your device.

**CHILDREN**
Reacnar does not knowingly collect data from any user regardless of age, as no data collection mechanisms exist within the application.

**CONTACT**
For questions or concerns regarding this policy, use the SUBMIT CENTRAL FEEDBACK link to reach the development team.
''';

// ── Sliding info view ─────────────────────────────────────────────────────────

class SlidingInformationView extends StatelessWidget {
  final String title;
  final String content;

  const SlidingInformationView({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final isDark = Theme.of(context).scaffoldBackgroundColor == Colors.black;
    final borderLine = isDark ? const Color(0xFF1F1F1F) : const Color(0xFFE5E5E5);
    final baseTextStyle = GoogleFonts.robotoMono(
        color: primaryColor.withOpacity(0.8), fontSize: 11, height: 1.6);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: GoogleFonts.robotoMono(
                          color: primaryColor, fontSize: 14, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(border: Border.all(color: primaryColor, width: 1.2)),
                      child: Text('RETURN',
                          style: GoogleFonts.robotoMono(
                              color: primaryColor, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              Divider(color: borderLine, height: 32, thickness: 0.8),
              Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: _buildParsedContent(content, baseTextStyle),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParsedContent(String text, TextStyle baseStyle) {
    final List<InlineSpan> spans = [];
    final RegExp regExp = RegExp(r'(\*\*.*?\*\*)');
    int lastIndex = 0;

    for (final match in regExp.allMatches(text)) {
      if (match.start > lastIndex) {
        spans.add(TextSpan(text: text.substring(lastIndex, match.start)));
      }
      final String matchText = match.group(0)!;
      spans.add(TextSpan(
        text: matchText.substring(2, matchText.length - 2),
        style: baseStyle.copyWith(
            fontWeight: FontWeight.bold, color: baseStyle.color?.withOpacity(1.0)),
      ));
      lastIndex = match.end;
    }
    if (lastIndex < text.length) spans.add(TextSpan(text: text.substring(lastIndex)));

    return RichText(text: TextSpan(style: baseStyle, children: spans));
  }
}