import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/ML_classifications.dart';
import '../models/sensor_readings.dart';
part 'classification_providers.g.dart';


@riverpod
class ClassificationsEnabled extends _$ClassificationsEnabled {
  @override
  bool build() {
    return false; // off until ML is ready
  }

  void enable() => state = true;
  void disable() => state = false;
}

@riverpod
class ClassificationEngine extends _$ClassificationEngine {
  @override
  Future<PositionClassification?> build() async {
    return Future.value(null); // explicitly a nullable value
  }

  Future<void> runClassification(List<SensorReading> window) async {
    if (window.isEmpty) return;

    // final result = await mlService.classify(window);
    // state = AsyncValue.data(result);
  }

  void clear() {
    state = const AsyncValue.data(null);
  }
}


@riverpod
class LatestClassification extends _$LatestClassification {
  @override
  PositionClassification? build() {
    return null;
  }

  void set(PositionClassification classification) {
    state = classification;
  }

  void clear() {
    state = null;
  }
}

@riverpod
class ClassificationHistory extends _$ClassificationHistory {
  @override
  Future<List<PositionClassification>> build(
      String patientId,
      String sessionId,
      ) async {
    // TODO: load classification history from Firestore
    return const [];
  }
}

@Riverpod(keepAlive: true)
class BaselineFrame extends _$BaselineFrame {
  @override
  List<double>? build() {
    return null;
  }

  void setBaseline(List<double> frame) {
    if (frame.length != 36) {
      throw Exception(
        'Baseline frame must contain 36 values.',
      );
    }

    state = frame;
  }

  void clear() {
    state = null;
  }


}


@Riverpod(keepAlive: true)
class CalibrationRunning extends _$CalibrationRunning {
  @override
  bool build() => false;

  void start() => state = true;
  void stop() => state = false;
}

@Riverpod(keepAlive: true)
class CalibrationCountdown extends _$CalibrationCountdown {
  @override
  int build() => 0;

  void set(int seconds) {
    state = seconds;
  }

  void clear() {
    state = 0;
  }
}


@Riverpod(keepAlive: true)
class CalibrationFrames extends _$CalibrationFrames {
  @override
  List<List<double>> build() {
    return [];
  }

  void addFrame(List<double> frame) {
    state = [...state, frame];
  }

  void clear() {
    state = [];
  }
}


@Riverpod(keepAlive: true)
class ClassificationRunning
    extends _$ClassificationRunning {
  @override
  bool build() => false;

  void start() => state = true;
  void stop() => state = false;
}


@Riverpod(keepAlive: true)
class ClassificationCountdown
    extends _$ClassificationCountdown {
  @override
  int build() => 0;

  void set(int seconds) {
    state = seconds;
  }

  void clear() {
    state = 0;
  }
}


@Riverpod(keepAlive: true)
class ClassificationFrames
    extends _$ClassificationFrames {
  @override
  List<List<double>> build() {
    return [];
  }

  void addFrame(List<double> frame) {
    state = [...state, frame];
  }

  void clear() {
    state = [];
  }
}


@Riverpod(keepAlive: true)
class CurrentFrame extends _$CurrentFrame {
  @override
  List<double>? build() {
    return null;
  }

  void setFrame(List<double> frame) {
    if (frame.length != 36) {
      throw Exception(
        'Current frame must contain 36 values.',
      );
    }

    state = frame;
  }

  void clear() {
    state = null;
  }
}


@Riverpod(keepAlive: true)
class FrameHistory extends _$FrameHistory {
  @override
  List<List<double>> build() => [];

  void addFrame(List<double> frame) {
    final updated = [...state, frame];

    state =
    updated.length > 100
        ? updated.sublist(
      updated.length - 100,
    )
        : updated;
  }

  void clear() {
    state = [];
  }
}


@Riverpod(keepAlive: true)
class NormalisedFrame extends _$NormalisedFrame {
  @override
  List<double>? build() {
    return null;
  }

  void setFrame(List<double> frame) {
    if (frame.length != 36) {
      throw Exception(
        'Normalised frame must contain 36 values.',
      );
    }

    state = frame;
  }

  void clear() {
    state = null;
  }
}

@Riverpod(keepAlive: true)
class PredictionResult
    extends _$PredictionResult {
  @override
  String? build() {
    return null;
  }

  void setPrediction(
      String prediction,
      ) {
    state = prediction;
  }

  void clear() {
    state = null;
  }
}

@Riverpod(keepAlive: true)
class PredictionConfidence
    extends _$PredictionConfidence {
  @override
  double? build() {
    return null;
  }

  void setConfidence(
      double confidence,
      ) {
    state = confidence;
  }

  void clear() {
    state = null;
  }
}
