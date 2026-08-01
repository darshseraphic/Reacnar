import 'package:hive_flutter/hive_flutter.dart';

class ReactionRecord {
  final String id;
  final int reactionMs;
  final bool isFalseStart;
  final DateTime timestamp;
  final String mode;

  ReactionRecord({
    required this.id,
    required this.reactionMs,
    required this.isFalseStart,
    required this.timestamp,
    this.mode = 'normal',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reactionMs': reactionMs,
      'isFalseStart': isFalseStart,
      'timestamp': timestamp.toIso8601String(),
      'mode': mode,
    };
  }

  factory ReactionRecord.fromMap(Map map) {
    return ReactionRecord(
      id: map['id'],
      reactionMs: map['reactionMs'] ?? 0,
      isFalseStart: map['isFalseStart'] ?? false,
      timestamp: DateTime.parse(map['timestamp']),
      mode: map['mode'] ?? 'normal',
    );
  }
}

class LocalDatabase {
  static final Box<Map> _logBox = Hive.box<Map>('reacnar_logs');

  static Future<void> commitRecord(ReactionRecord record) async {
    await _logBox.put(record.id, record.toMap());
  }

  static List<ReactionRecord> fetchAllRecords() {
    return _logBox.values.map((e) => ReactionRecord.fromMap(e)).toList();
  }

  static Future<void> purgeTelemetry() async {
    await _logBox.clear();
  }
}