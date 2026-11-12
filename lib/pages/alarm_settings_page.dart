import 'package:first_app/data/repositories/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient.dart';
import '../models/max_pressure_config.dart';
import '../models/patient_alarm_settings.dart';
import '/../state/patient_providers.dart';

class AlarmSettingsPage extends ConsumerStatefulWidget {
  final Patient? patient;

  const AlarmSettingsPage({
    super.key,
    required this.patient,
  });

  @override
  ConsumerState<AlarmSettingsPage> createState() =>
      _AlarmSettingsPageState();
}

class _AlarmSettingsPageState
    extends ConsumerState<AlarmSettingsPage> {
  bool alarmsEnabled = false;

  final _repo = FirestoreRepository();

  Future<void> _loadSettings() async {
    if (widget.patient == null) {
      return;
    }

    final settings =
    await _repo.loadPatientAlarmSettings(
      widget.patient!.id,
    );

    alarmsEnabled =
        settings.maxPressureEnabled;

    for (int i = 1; i <= 36; i++) {
      final config =
      settings.sensorConfigs[i]!;

      thresholdControllers[i - 1].text =
          config.threshold.toString();

      frameControllers[i - 1].text =
          config.framesRequired.toString();
    }

    setState(() {});
  }

  late final List<TextEditingController>
  thresholdControllers;

  late final List<TextEditingController>
  frameControllers;

  @override
  void initState() {
    super.initState();

    thresholdControllers =
        List.generate(
          36,
              (_) => TextEditingController(text: '1.0'),
        );

    frameControllers =
        List.generate(
          36,
              (_) => TextEditingController(text: '60'),
        );

    _loadSettings();
  }

  @override
  void dispose() {
    for (final controller
    in thresholdControllers) {
      controller.dispose();
    }

    for (final controller
    in frameControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  void restoreDefaults() {
    for (final controller
    in thresholdControllers) {
      controller.text = '1.0';
    }

    for (final controller
    in frameControllers) {
      controller.text = '60';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Alarm Settings',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Patient: '
                  '${widget.patient?.name ?? "Unknown"}',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium,
            ),

            const SizedBox(height: 16),

            CheckboxListTile(
              title: const Text(
                'Enable Max Pressure Alarm',
              ),
              value: alarmsEnabled,
              onChanged: (value) {
                setState(() {
                  alarmsEnabled =
                      value ?? false;
                });
              },
            ),

            const SizedBox(height: 8),

            const Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    'Sensor',
                    style: TextStyle(
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Threshold',
                    style: TextStyle(
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Frames',
                    style: TextStyle(
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const Divider(),

            Expanded(
              child: ListView.builder(
                itemCount: 36,
                itemBuilder:
                    (context, index) {
                  final sensor =
                      index + 1;

                  return Padding(
                    padding:
                    const EdgeInsets
                        .symmetric(
                      vertical: 4,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 60,
                          child: Text(
                            'S$sensor',
                          ),
                        ),

                        Expanded(
                          child: TextField(
                            controller:
                            thresholdControllers[
                            index],
                            keyboardType:
                            const TextInputType
                                .numberWithOptions(
                              decimal: true,
                            ),
                            decoration:
                            const InputDecoration(
                              border:
                              OutlineInputBorder(),
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 12,
                        ),

                        Expanded(
                          child: TextField(
                            controller:
                            frameControllers[
                            index],
                            keyboardType:
                            TextInputType
                                .number,
                            decoration:
                            const InputDecoration(
                              border:
                              OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed:
                    restoreDefaults,
                    child: const Text(
                      'Restore Defaults',
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: FilledButton(
                    onPressed: () async {
                      if (widget.patient == null) {
                        return;
                      }

                      final configs =
                      <int, MaxPressureConfig>{};

                      for (int i = 1; i <= 36; i++) {
                        configs[i] = MaxPressureConfig(
                          enabled: true,
                          threshold: double.tryParse(
                            thresholdControllers[i - 1].text,
                          ) ??
                              1.0,
                          framesRequired: int.tryParse(
                            frameControllers[i - 1].text,
                          ) ??
                              60,
                        );
                      }

                      final settings =
                      PatientAlarmSettings(
                        maxPressureEnabled:
                        alarmsEnabled,
                        sensorConfigs: configs,
                      );

                      await _repo.savePatientAlarmSettings(
                        widget.patient!.id,
                        settings,
                      );

                      ref
                          .read(
                        activePatientAlarmSettingsProvider
                            .notifier,
                      )
                          .setSettings(settings);

                      if (mounted) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Alarm settings saved',
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Save',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}