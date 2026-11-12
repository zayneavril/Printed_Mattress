import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/../state/classification_providers.dart';
import 'normalisation_service.dart';
import 'ml_service.dart';
class ClassificationService {
  final WidgetRef ref;

  ClassificationService(this.ref);

  Future<int> startClassification() async {
    if (ref.read(classificationRunningProvider)) {
      return 0;
    }

    ref.read(currentFrameProvider.notifier).clear();

    ref.read(classificationFramesProvider.notifier).clear();

    ref.read(classificationRunningProvider.notifier).start();

    for (int seconds = 15; seconds > 0; seconds--) {
      ref
          .read(classificationCountdownProvider.notifier)
          .set(seconds);

      await Future.delayed(
        const Duration(seconds: 1),
      );
    }

    final frameCount =
    await _finishClassification();

    return frameCount;
  }

  Future<int> _finishClassification() async {
    final frames = ref.read(
      classificationFramesProvider,
    );

    final frameCount = frames.length;

    print(
      'Classification collected using '
          '$frameCount frames',
    );

    if (frames.isEmpty) {
      ref
          .read(classificationRunningProvider.notifier)
          .stop();

      ref
          .read(classificationCountdownProvider.notifier)
          .clear();

      throw Exception(
        'No classification frames collected.',
      );
    }

    final currentFrame =
    List<double>.generate(
      36,
          (sensorIndex) {
        double sum = 0;

        for (final frame in frames) {
          sum += frame[sensorIndex];
        }

        return sum / frames.length;
      },
    );

    ref
        .read(currentFrameProvider.notifier)
        .setFrame(currentFrame);

    final baseline =
    ref.read(baselineFrameProvider);

    if (baseline == null) {
      throw Exception(
        'No baseline available.',
      );
    }

    final normalised =
    NormalisationService.normalise(
      frame: currentFrame,
      baseline: baseline,
    );

    ref
        .read(normalisedFrameProvider.notifier)
        .setFrame(normalised);

    ref
        .read(classificationFramesProvider.notifier)
        .clear();

    ref
        .read(classificationRunningProvider.notifier)
        .stop();

    ref
        .read(classificationCountdownProvider.notifier)
        .clear();

    final mlService = MlService();

    final result = await mlService.predict(
      normalised,
    );

    ref
        .read(predictionResultProvider.notifier)
        .setPrediction(
      result.prediction,
    );

    ref
        .read(predictionConfidenceProvider.notifier)
        .setConfidence(
      result.confidence,
    );



    return frameCount;
  }
}



