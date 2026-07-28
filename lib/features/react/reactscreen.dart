import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/database.dart';

enum ArenaState { idle, waiting, triggered, finished, penalty }

enum ArenaMode { normal, burst, click }

class ReactScreen extends StatefulWidget {
  const ReactScreen({super.key});

  @override
  State<ReactScreen> createState() => _ReactScreenState();
}

class _ReactScreenState extends State<ReactScreen> {
  ArenaState _currentState = ArenaState.idle;
  ArenaMode _currentMode = ArenaMode.normal;

  final Stopwatch _precisionClock = Stopwatch();
  Timer? _countdownTimer;
  Timer? _clickTimer;

  int _lastRecordedDelta = 0;

  int _burstTotalTicks = 0;
  int _burstTicksFired = 0;
  final List<int> _burstDeltas = [];

  int _clickCount = 0;
  int _clickSecondsRemaining = 60;

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _clickTimer?.cancel();
    super.dispose();
  }

  void _selectMode(ArenaMode mode) {
    _countdownTimer?.cancel();
    _clickTimer?.cancel();
    _precisionClock.stop();
    _precisionClock.reset();
    setState(() {
      _currentMode = mode;
      _currentState = ArenaState.idle;
      _clickCount = 0;
      _clickSecondsRemaining = 60;
      _burstTicksFired = 0;
      _lastRecordedDelta = 0;
      _burstDeltas.clear();
    });
  }

  void _triggerArenaAction() {
    final settings = Hive.box('reacnar_settings');
    final double minDelay = settings.get('min_delay', defaultValue: 1.0);
    final double maxDelay = settings.get('max_delay', defaultValue: 10.0);
    final bool hapticsEnabled = settings.get(
      'haptics_enabled',
      defaultValue: true,
    );
    if (_currentMode == ArenaMode.normal) {
      if (_currentState == ArenaState.idle ||
          _currentState == ArenaState.finished ||
          _currentState == ArenaState.penalty) {
        setState(() {
          _currentState = ArenaState.waiting;
          _lastRecordedDelta = 0;
        });

        final randomRange = minDelay == maxDelay
            ? minDelay
            : minDelay + Random().nextDouble() * (maxDelay - minDelay);
        final millisecondsDelay = (randomRange * 1000).toInt();

        _countdownTimer = Timer(Duration(milliseconds: millisecondsDelay), () {
          if (mounted) {
            setState(() {
              _currentState = ArenaState.triggered;
            });
            _precisionClock.reset();
            _precisionClock.start();
            if (hapticsEnabled) HapticFeedback.lightImpact();
          }
        });
        return;
      }

      if (_currentState == ArenaState.waiting) {
        _countdownTimer?.cancel();
        final bool antiCheat = settings.get('anti_cheat', defaultValue: true);

        setState(() {
          _currentState = antiCheat ? ArenaState.penalty : ArenaState.idle;
        });

        LocalDatabase.commitRecord(
          ReactionRecord(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            reactionMs: 0,
            isFalseStart: true,
            timestamp: DateTime.now(),
          ),
        );

        if (hapticsEnabled) HapticFeedback.heavyImpact();
        return;
      }

      if (_currentState == ArenaState.triggered) {
        _precisionClock.stop();
        _lastRecordedDelta = _precisionClock.elapsedMilliseconds;

        setState(() {
          _currentState = ArenaState.finished;
        });

        LocalDatabase.commitRecord(
          ReactionRecord(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            reactionMs: _lastRecordedDelta,
            isFalseStart: false,
            timestamp: DateTime.now(),
          ),
        );

        if (hapticsEnabled) HapticFeedback.lightImpact();
        _precisionClock.reset();
      }
    } else if (_currentMode == ArenaMode.burst) {
      if (_currentState == ArenaState.idle ||
          _currentState == ArenaState.finished ||
          _currentState == ArenaState.penalty) {
        setState(() {
          _currentState = ArenaState.waiting;
          _lastRecordedDelta = 0;
          _burstTicksFired = 0;
          _burstDeltas.clear();
          _burstTotalTicks = 3 + Random().nextInt(3);
        });

        final randomRange = minDelay == maxDelay
            ? minDelay
            : minDelay + Random().nextDouble() * (maxDelay - minDelay);
        final millisecondsDelay = (randomRange * 1000).toInt();

        _countdownTimer = Timer(
          Duration(milliseconds: millisecondsDelay),
          _fireBurstTick,
        );
        return;
      }

      if (_currentState == ArenaState.waiting) {
        _countdownTimer?.cancel();
        final bool antiCheat = settings.get('anti_cheat', defaultValue: true);

        setState(() {
          _currentState = antiCheat ? ArenaState.penalty : ArenaState.idle;
        });

        LocalDatabase.commitRecord(
          ReactionRecord(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            reactionMs: 0,
            isFalseStart: true,
            timestamp: DateTime.now(),
          ),
        );

        if (hapticsEnabled) HapticFeedback.heavyImpact();
        return;
      }

      if (_currentState == ArenaState.triggered) {
        _precisionClock.stop();
        int delta = _precisionClock.elapsedMilliseconds;
        _burstDeltas.add(delta);
        _burstTicksFired++;

        LocalDatabase.commitRecord(
          ReactionRecord(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            reactionMs: delta,
            isFalseStart: false,
            timestamp: DateTime.now(),
            mode: 'burst',
          ),
        );

        if (hapticsEnabled) HapticFeedback.lightImpact();
        _precisionClock.reset();

        if (_burstTicksFired < _burstTotalTicks) {
          setState(() {
            _currentState = ArenaState.waiting;
          });
          int microInterval = 150 + Random().nextInt(300);
          _countdownTimer = Timer(
            Duration(milliseconds: microInterval),
            _fireBurstTick,
          );
        } else {
          setState(() {
            _currentState = ArenaState.finished;
            double sum = _burstDeltas.reduce((a, b) => a + b).toDouble();
            _lastRecordedDelta = (sum / _burstTotalTicks).round();
          });
        }
      }
    } else if (_currentMode == ArenaMode.click) {
      if (_currentState == ArenaState.idle ||
          _currentState == ArenaState.finished ||
          _currentState == ArenaState.penalty) {
        setState(() {
          _currentState = ArenaState.triggered;
          _clickCount = 1;
          _clickSecondsRemaining = 60;
        });

        _clickTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (mounted) {
            setState(() {
              _clickSecondsRemaining--;
              if (_clickSecondsRemaining <= 0) {
                _clickTimer?.cancel();
                _currentState = ArenaState.finished;

                LocalDatabase.commitRecord(
                  ReactionRecord(
                    id: DateTime.now().microsecondsSinceEpoch.toString(),
                    reactionMs: _clickCount,
                    isFalseStart: false,
                    timestamp: DateTime.now(),
                    mode: 'click',
                  ),
                );
              }
            });
          }
        });

        if (hapticsEnabled) HapticFeedback.lightImpact();
      } else if (_currentState == ArenaState.triggered) {
        setState(() {
          _clickCount++;
        });
        if (hapticsEnabled) HapticFeedback.lightImpact();
      }
    }
  }

  void _fireBurstTick() {
    if (mounted) {
      setState(() {
        _currentState = ArenaState.triggered;
      });
      _precisionClock.reset();
      _precisionClock.start();
      final settings = Hive.box('reacnar_settings');
      if (settings.get('haptics_enabled', defaultValue: true)) {
        HapticFeedback.lightImpact();
      }
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

    Color dotColor = scaffoldBg;
    String statusMessage = "";

    if (_currentMode == ArenaMode.normal) {
      if (_currentState == ArenaState.idle) {
        statusMessage = "NORMAL:- TAP WHEN COLOR CHANGE.";
      } else if (_currentState == ArenaState.waiting) {
        dotColor = scaffoldBg;
        statusMessage = "AWAITING UNPREDICTABLE MATRIX COLD PULSE...";
      } else if (_currentState == ArenaState.triggered) {
        dotColor = primaryColor;
        statusMessage = "TRIGGER ACQUIRED: DETONATE ACTIONS IMMEDIATELY";
      } else if (_currentState == ArenaState.finished) {
        dotColor = scaffoldBg;
        statusMessage = "RESPONSE RECORDED: ${_lastRecordedDelta}MS";
      } else if (_currentState == ArenaState.penalty) {
        dotColor = const Color(0xFFEF4444);
        statusMessage = "FALSE START PENALTY ROUTINE INJECTED";
      }
    } else if (_currentMode == ArenaMode.burst) {
      if (_currentState == ArenaState.idle) {
        statusMessage = "BURST:- TAP WHEN COLOR FIRES.";
      } else if (_currentState == ArenaState.waiting) {
        dotColor = scaffoldBg;
        statusMessage = "AWAITING UNPREDICTABLE BURST STREAM CLUSTER...";
      } else if (_currentState == ArenaState.triggered) {
        dotColor = primaryColor;
        statusMessage =
            "BURST TICK FIRE ${_burstTicksFired + 1}/${_burstTotalTicks}: DETONATE NOW!";
      } else if (_currentState == ArenaState.finished) {
        dotColor = scaffoldBg;
        statusMessage =
            "BURST COMPLETED! CLUSTER MEAN: ${_lastRecordedDelta}MS";
      } else if (_currentState == ArenaState.penalty) {
        dotColor = const Color(0xFFEF4444);
        statusMessage = "FALSE START PENALTY ROUTINE INJECTED";
      }
    } else if (_currentMode == ArenaMode.click) {
      if (_currentState == ArenaState.idle) {
        dotColor = scaffoldBg;
        statusMessage = "CLICK:- CLICK AS MUCH AS YOU CAN.";
      } else if (_currentState == ArenaState.triggered) {
        dotColor = primaryColor.withOpacity(0.15);
        statusMessage =
            "MASH DISPLAY BOUNDS! TAPS: $_clickCount | TIME: ${_clickSecondsRemaining}S";
      } else if (_currentState == ArenaState.finished) {
        dotColor = scaffoldBg;
        statusMessage = "CHALLENGE COMPLETE: $_clickCount TAPS IN 60S!";
      }
    }

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'REACNAR // REFLEX FIELD',
              style: GoogleFonts.robotoMono(
                color: primaryColor.withOpacity(0.5),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: _triggerArenaAction,
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: dotColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: primaryColor, width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    statusMessage,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.robotoMono(
                      color: _currentState == ArenaState.penalty
                          ? const Color(0xFFEF4444)
                          : primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.02,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          Container(
            height: 44,
            decoration: BoxDecoration(
              border: Border.all(color: borderLine, width: 0.8),
            ),
            child: Row(
              children: [
                _buildModeTab(ArenaMode.normal, 'NORMAL', primaryColor),
                Container(width: 0.8, color: borderLine),
                _buildModeTab(ArenaMode.burst, 'BURST', primaryColor),
                Container(width: 0.8, color: borderLine),
                _buildModeTab(ArenaMode.click, 'CLICK', primaryColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeTab(ArenaMode mode, String label, Color primary) {
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
}
