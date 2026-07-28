import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/database.dart';

enum AnalyticsMode { normal, burst, click }

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  AnalyticsMode _currentMode = AnalyticsMode.normal;

  List<ReactionRecord> _filteredHistory = [];
  int _fastest = 0;
  int _slowest = 0;
  double _overallAverage = 0.0;
  int _totalFalseStarts = 0;
  Map<int, List<int>> _dayAveragesMap = {};

  @override
  void initState() {
    super.initState();
    _processTelemetry();
  }

  void _selectMode(AnalyticsMode mode) {
    setState(() {
      _currentMode = mode;
    });
    _processTelemetry();
  }

  void _processTelemetry() {
    final allRecords = LocalDatabase.fetchAllRecords();

    String targetModeStr = 'normal';
    if (_currentMode == AnalyticsMode.burst) targetModeStr = 'burst';
    if (_currentMode == AnalyticsMode.click) targetModeStr = 'click';

    final records = allRecords
        .where((element) => element.mode == targetModeStr)
        .toList();

    if (records.isEmpty) {
      setState(() {
        _filteredHistory = [];
        _fastest = 0;
        _slowest = 0;
        _totalFalseStarts = 0;
        _overallAverage = 0.0;
        _dayAveragesMap = {1: [], 2: [], 3: [], 4: [], 5: [], 6: [], 7: []};
      });
      return;
    }
    int currentFastest = _currentMode == AnalyticsMode.click ? 0 : 99999;
    int currentSlowest = _currentMode == AnalyticsMode.click ? 0 : 99999;

    int validTicksSum = 0;
    int validTicksCount = 0;
    int falseStarts = 0;
    Map<int, List<int>> dailyBlocks = {
      1: [],
      2: [],
      3: [],
      4: [],
      5: [],
      6: [],
      7: [],
    };

    for (var record in records) {
      if (record.isFalseStart) {
        falseStarts++;
      } else {
        validTicksCount++;
        validTicksSum += record.reactionMs;
        if (_currentMode == AnalyticsMode.click) {
          if (record.reactionMs > currentFastest)
            currentFastest = record.reactionMs;
          if (currentSlowest == 0 || record.reactionMs < currentSlowest) {
            currentSlowest = record.reactionMs;
          }
        } else {
          if (record.reactionMs < currentFastest)
            currentFastest = record.reactionMs;
          if (record.reactionMs > currentSlowest)
            currentSlowest = record.reactionMs;
        }

        int weekday = record.timestamp.weekday;
        dailyBlocks[weekday]?.add(record.reactionMs);
      }
    }

    setState(() {
      _filteredHistory = records;
      _fastest =
          (_currentMode != AnalyticsMode.click && currentFastest == 99999)
          ? 0
          : currentFastest;
      _slowest =
          (_currentMode != AnalyticsMode.click && currentSlowest == 99999)
          ? 0
          : currentSlowest;
      _totalFalseStarts = falseStarts;
      _overallAverage = validTicksCount > 0
          ? validTicksSum / validTicksCount
          : 0.0;
      _dayAveragesMap = dailyBlocks;
    });
  }

  String _getBiologicalTier(double metric) {
    if (metric <= 0) return "N/A SYSTEM DATA";

    if (_currentMode == AnalyticsMode.click) {
      if (metric >= 400) return "CYBERNETIC SPEED SPECIFICATION";
      if (metric >= 300) return "HYPER-TAP ATHLETIC CONDITION";
      if (metric >= 180) return "TRAINED MOTOR RESPONSE SYSTEM";
      return "STANDARD BIOLOGICAL TAPPING RATE";
    } else {
      if (metric < 140) return "ELITE REFLEX SPECIFICATION";
      if (metric < 200) return "PRO ATHLETIC CONDITION";
      if (metric < 260) return "TRAINED MILITARY COMBATANT";
      return "STANDARD BIOLOGICAL BASELINE";
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final scaffoldBg = Theme.of(context).scaffoldBackgroundColor;
    final isDark = scaffoldBg == Colors.black;
    final borderLine = isDark
        ? const Color(0xFF1F1F1F)
        : const Color(0xFFE5E5E5);
    final List<String> shortDays = [
      'MON',
      'TUE',
      'WED',
      'THU',
      'FRI',
      'SAT',
      'SUN',
    ];

    String profileLabel = "BIOLOGICAL PERFORMANCE PROFILE";
    String counterLabel = "SYSTEM TOTAL ENGAGEMENTS";
    String primaryStatLabel = "ALL-TIME VELOCITY MINIMA (PR)";
    String secondaryStatLabel = "ALL-TIME VELOCITY MAXIMA";
    String averageStatLabel = "COMPUTED SESSION MEAN DELTA";

    String primaryValue = "$_fastest MS";
    String secondaryValue = "$_slowest MS";
    String averageValue = "${_overallAverage.toInt()} MS";

    if (_currentMode == AnalyticsMode.click) {
      profileLabel = "BIOLOGICAL MOTOR TAPPING RATIO";
      counterLabel = "COMPLETED SPEED RUN TRIALS";
      primaryStatLabel = "MAXIMUM RECORDED TAP VOLUME (PR)";
      secondaryStatLabel = "MINIMUM RECORDED TAP VOLUME";
      averageStatLabel = "COMPUTED SESSION TAPPING MEAN";

      primaryValue = "$_fastest TAPS";
      secondaryValue = "$_slowest TAPS";
      averageValue = "${_overallAverage.toInt()} TAPS / MIN";
    }

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TELEMETRY DASHBOARD',
            style: GoogleFonts.robotoMono(
              color: primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.02,
            ),
          ),
          const SizedBox(height: 20),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor, width: 0.8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profileLabel,
                  style: GoogleFonts.robotoMono(
                    color: primaryColor.withOpacity(0.5),
                    fontSize: 9,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _getBiologicalTier(_overallAverage),
                  style: GoogleFonts.robotoMono(
                    color: primaryColor,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Row(
            children: List.generate(7, (index) {
              final dayNum = index + 1;
              final dayTimes = _dayAveragesMap[dayNum] ?? [];
              final double avg = dayTimes.isEmpty
                  ? 0.0
                  : dayTimes.reduce((a, b) => a + b) / dayTimes.length;

              double maxHeightLimit = _currentMode == AnalyticsMode.click
                  ? 500.0
                  : 1000.0;
              double barCalculation = (avg / maxHeightLimit * 80).clamp(
                4.0,
                80.0,
              );

              return Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Container(
                        width: double.infinity,
                        height: avg == 0.0 ? 2 : barCalculation,
                        color: primaryColor.withOpacity(avg == 0.0 ? 0.1 : 0.8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      shortDays[index],
                      style: GoogleFonts.robotoMono(
                        color: primaryColor,
                        fontSize: 9,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      avg == 0.0 ? '-' : '${avg.toInt()}',
                      style: GoogleFonts.robotoMono(
                        color: primaryColor.withOpacity(0.5),
                        fontSize: 8,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),

          Divider(color: borderLine, height: 32, thickness: 0.8),

          Expanded(
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                _buildMetricRow(
                  counterLabel,
                  '${_filteredHistory.length}',
                  primaryColor,
                  borderLine,
                ),
                _buildMetricRow(
                  primaryStatLabel,
                  primaryValue,
                  primaryColor,
                  borderLine,
                ),
                _buildMetricRow(
                  secondaryStatLabel,
                  secondaryValue,
                  primaryColor,
                  borderLine,
                ),
                _buildMetricRow(
                  averageStatLabel,
                  averageValue,
                  primaryColor,
                  borderLine,
                ),
                _buildMetricRow(
                  'ANTI-CHEAT INFRACTIONS TRAPPED',
                  '$_totalFalseStarts',
                  const Color(0xFFEF4444),
                  borderLine,
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () async {
                    await LocalDatabase.purgeTelemetry();
                    _processTelemetry();
                  },
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFEF4444),
                        width: 0.8,
                      ),
                    ),
                    child: Text(
                      'PURGE ALL SYSTEM METRICS',
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFFEF4444),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),

          Container(
            height: 44,
            decoration: BoxDecoration(
              border: Border.all(color: borderLine, width: 0.8),
            ),
            child: Row(
              children: [
                _buildAnalyticsModeTab(
                  AnalyticsMode.normal,
                  'NORMAL',
                  primaryColor,
                ),
                Container(width: 0.8, color: borderLine),
                _buildAnalyticsModeTab(
                  AnalyticsMode.burst,
                  'BURST',
                  primaryColor,
                ),
                Container(width: 0.8, color: borderLine),
                _buildAnalyticsModeTab(
                  AnalyticsMode.click,
                  'CLICK',
                  primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsModeTab(
    AnalyticsMode mode,
    String label,
    Color primary,
  ) {
    final bool isActive = _currentMode == mode;
    return Expanded(
      child: InkWell(
        onTap: () => _selectMode(mode),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          color: isActive ? primary.withOpacity(0.06) : Colors.transparent,
          child: Text(
            isActive ? '[$label]' : label,
            style: GoogleFonts.robotoMono(
              color: isActive ? primary : primary.withOpacity(0.4),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetricRow(String title, String data, Color primary, Color line) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: line, width: 0.8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.robotoMono(
                color: primary.withOpacity(0.6),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            data,
            style: GoogleFonts.robotoMono(
              color: primary,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
