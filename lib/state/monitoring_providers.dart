import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod/riverpod.dart' show Ref;
import '../models/sensor_readings.dart';
import 'mqtt_providers.dart';
part 'monitoring_providers.g.dart';


@riverpod
class LatestSensorValues extends _$LatestSensorValues {
  @override
  Map<int, double> build() {
    return {};
  }

  void update(SensorReading reading) {
    state = {
      ...state,
      reading.sensorNumber: reading.values.first,
    };
  }

  void clear() {
    state = {};
  }
}

@riverpod
class SlidingWindow extends _$SlidingWindow {
  @override
  List<SensorReading> build() {
    return [];
  }





  void add(SensorReading reading, {int windowSeconds = 10}) {
    final updated = [...state, reading];
    final cutoff =
    reading.timestamp.subtract(Duration(seconds: windowSeconds));
    state = updated.where((r) => r.timestamp.isAfter(cutoff)).toList();
  }

  void clear() {
    state = [];
  }
}

@riverpod
class MonitoringMode extends _$MonitoringMode {
  @override
  String build() => 'monitoring';

  void setMonitoring() => state = 'monitoring';
  void setCalibration() => state = 'calibration';
}

@riverpod
class VisibleSensors extends _$VisibleSensors {
  @override
  Set<int> build() {
    // only 6 Sensors visible by default
    return {9, 4, 16, 21, 28, 33};

    //all 36 sensors visible by defauls
    // return Set<int>.from(List.generate(36, (i) => i + 1));
  }

  void toggle(int sensor) {
    if (state.contains(sensor)) {
      state = {...state}..remove(sensor);
    } else {
      state = {...state, sensor};
    }
  }

  void showAll() {
    state = Set<int>.from(List.generate(35, (i) => i + 1));
  }

  void clear() {
    state = {};
  }
}

@riverpod
class LegendExpanded extends _$LegendExpanded {
  @override
  bool build() => false;

  void toggle() => state = !state;
}

@riverpod
class ShowPressureValues
    extends _$ShowPressureValues {

  @override
  bool build() => true;

  void toggle() {
    state = !state;
  }
}

@riverpod
class SessionPanelExpanded
    extends _$SessionPanelExpanded {

  @override
  bool build() => false;

  void toggle() {
    state = !state;
  }
}