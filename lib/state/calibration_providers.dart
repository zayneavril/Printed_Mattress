import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod/riverpod.dart';
import '../models/sensor_readings.dart';


part 'calibration_providers.g.dart';

@riverpod
class CalibrationMode extends _$CalibrationMode {
  @override
  bool build() => false;

  void enable() => state = true;
  void disable() => state = false;
}

@riverpod
Stream<SensorReading> liveReadings(Ref ref) async* {
  // TEMP FIX: ensures Riverpod generates the correct provider type
  yield* const Stream.empty();
  //yield* mqttService.readingStream;
}

