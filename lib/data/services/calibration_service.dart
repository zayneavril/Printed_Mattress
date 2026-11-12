import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/../state/classification_providers.dart';

class CalibrationService {
  final WidgetRef ref;

  CalibrationService(this.ref);

  Future<int> startCalibration() async {
    // Prevent re-entry
    print('Calibration started');
    if (ref.read(calibrationRunningProvider)) {
      return 0;
    }


    // Clear previous baseline
    ref.read(baselineFrameProvider.notifier).clear();

    // Clear previous collected frames
    ref.read(calibrationFramesProvider.notifier).clear();

    ref.read(calibrationRunningProvider.notifier).start();

    // 15-second countdown
    for (int seconds = 15; seconds > 0; seconds--) {
      ref
          .read(calibrationCountdownProvider.notifier)
          .set(seconds);

      await Future.delayed(
        const Duration(seconds: 1),
      );
    }

    print(
      'Frames collected before finish: '
          '${ref.read(calibrationFramesProvider).length}',
    );

    final frameCount = await _finishCalibration();

    return frameCount;
  }

  Future<int> _finishCalibration() async {
    final frames = ref.read(
      calibrationFramesProvider,
    );

    final frameCount = frames.length;

    print(
      'Baseline collected using $frameCount frames',
    );

    if (frames.isEmpty) {
      ref.read(calibrationRunningProvider.notifier).stop();
      ref.read(calibrationCountdownProvider.notifier).clear();

      throw Exception(
        'No calibration frames collected.',
      );
    }

    final baseline = List<double>.generate(
      210,
          (sensorIndex) {
        double sum = 0;

        for (final frame in frames) {
          sum += frame[sensorIndex];
        }

        return sum / frames.length;
      },
    );

    ref
        .read(baselineFrameProvider.notifier)
        .setBaseline(baseline);

    ref.read(calibrationFramesProvider.notifier).clear();

    ref.read(calibrationRunningProvider.notifier).stop();

    ref.read(calibrationCountdownProvider.notifier).clear();

      return frameCount;
  }

}