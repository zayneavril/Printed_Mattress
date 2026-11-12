import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/sensor_readings.dart';

part 'playback_providers.g.dart';

class PlaybackFilters {
  final String? patientId;
  final String? sessionId;
  final DateTime? from;
  final DateTime? to;

  const PlaybackFilters({
    this.patientId,
    this.sessionId,
    this.from,
    this.to,
  });

  PlaybackFilters copyWith({
    String? patientId,
    String? sessionId,
    DateTime? from,
    DateTime? to,
  }) {
    return PlaybackFilters(
      patientId: patientId ?? this.patientId,
      sessionId: sessionId ?? this.sessionId,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }
}

@riverpod
class PlaybackMode extends _$PlaybackMode {
  @override
  String build() {
    return 'live'; // 'live' | 'historical'
  }

  void setLive() => state = 'live';
  void setHistorical() => state = 'historical';
}

@riverpod
class PlaybackFiltersController extends _$PlaybackFiltersController {
  @override
  PlaybackFilters build() {
    return const PlaybackFilters();
  }

  void setPatient(String? id) {
    state = state.copyWith(patientId: id);
  }

  void setSession(String? id) {
    state = state.copyWith(sessionId: id);
  }

  void setRange(DateTime? from, DateTime? to) {
    state = state.copyWith(from: from, to: to);
  }

  void clear() {
    state = const PlaybackFilters();
  }
}

@riverpod
class PlaybackData extends _$PlaybackData {
  @override
  Future<List<SensorReading>> build(PlaybackFilters filters) async {
    // TODO: query Firestore using filters.patientId, filters.sessionId, filters.from, filters.to
    return const [];
  }
}

@riverpod
class PlaybackController extends _$PlaybackController {
  @override
  Duration build() {
    return Duration.zero; // current playback position
  }

  void seek(Duration position) {
    state = position;
  }

  void reset() {
    state = Duration.zero;
  }
}
