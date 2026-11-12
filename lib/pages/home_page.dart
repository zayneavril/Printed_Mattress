
import 'package:first_app/widgets/app_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/patient.dart';
import '../models/monitoring_session.dart';
import '../models/sensor_readings.dart';

import '../state/patient_providers.dart';
import '../state/mqtt_connection_provider.dart';
import '../state/calibration_providers.dart';
import '../state/monitoring_session_provider.dart';
import '../state/monitoring_providers.dart';
import '../state/mqtt_providers.dart';

import '../widgets/app_scaffold.dart';
import '../pages/start_page.dart';
import '../pages/pressure_map_page.dart';
import '../pages/position_page.dart';
import '../data/repositories/firestore_repository.dart';
import '../state/classification_providers.dart';
import '../data/services/calibration_service.dart';
import '../data/services/classification_service.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController _sessionNameController =
  TextEditingController();

  String? _pendingSessionName;
  String? _pendingPatientId;
  bool _sessionReady = false;

  //1: Provide a reusable EMPTY pressure reading for fallback
  final emptyReading = SensorReading(
    id: "empty",                     // FIX-1A
    sensorNumber: 0,                 // FIX-1B
    timestamp: DateTime(1970),       // FIX-1C
    values: List.filled(36, 0.0),    // FIX-1D
  );

  @override
  void dispose() {
    _sessionNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final patient = ref.watch(activePatientProvider);
    final connected = ref.watch(mqttConnectionProvider);
    final calibration = ref.watch(calibrationModeProvider);
    final session = ref.watch(monitoringSessionControllerProvider);
   // final readings = ref.watch(mqttReadingsProvider);

    final calibrationRunning =
    ref.watch(calibrationRunningProvider);

    final calibrationCountdown =
    ref.watch(calibrationCountdownProvider);

    final baseline =
    ref.watch(baselineFrameProvider);

    final classificationRunning =
    ref.watch(classificationRunningProvider);

    final classificationCountdown =
    ref.watch(classificationCountdownProvider);




    final monitoringActive = session != null && session.endTime == null;
    final sessionCompleted = session != null && session.endTime != null;

    if (_pendingPatientId == null && patient != null) {
      _pendingPatientId = patient.id;
    }

    final title = calibration
        ? 'Calibration Mode'
        : 'Monitoring: ${patient?.name ?? "No patient"}';

    return AppScaffold(
      currentIndex: 1,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A1B2A),                            // //6.1 match dark theme
        elevation: 0,                                                         // //6.2 modern flat header

        title: AppTitle(
          title),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), // //6.4 pill shape padding
            decoration: BoxDecoration(
              color: connected                                                     // //6.5 connection pill color
                  ? Colors.green.withValues(alpha: 0.15)
                  : Colors.red.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(
                  connected ? Icons.circle : Icons.circle_outlined,
                  color: connected ? Colors.greenAccent : Colors.redAccent,        // //6.6 softer neon colors
                  size: 12,
                ),
                const SizedBox(width: 6),
                Text(
                  connected ? "Connected" : "Disconnected",
                  style: TextStyle(
                    color: connected ? Colors.greenAccent : Colors.redAccent,       // //6.7 Sleep-like glow text
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),



      child: Column(
        children: [
          if (!connected)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(                                           // //6.8 modern red alert gradient
                  colors: [
                    Colors.red.shade800,
                    Colors.red.shade600,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Text(
                  'Device Disconnected',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,                                                    // //6.9 clean contrast text
                  ),
                ),
              ),
            )
          else if (baseline == null)
            Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.orange.shade800,
                      Colors.orange.shade600,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              child: const Center(
                child: Text(
                  'Baseline Required to Begin',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

          if (calibration)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.orange.shade300,
              child: const Text(
                'Calibration Mode',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),

          const SizedBox(height: 8),

          if (!calibration && patient != null)
            Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              child: Column(
                children: [
                  ListTile(
                    dense: true,
                    title: const Text(
                      'Patient & Session',
                    ),
                    trailing: Icon(
                      ref.watch(
                        sessionPanelExpandedProvider,
                      )
                          ? Icons.expand_less
                          : Icons.expand_more,
                    ),
                    onTap: () {
                      ref
                          .read(
                        sessionPanelExpandedProvider
                            .notifier,
                      )
                          .toggle();
                    },
                  ),

                  if (ref.watch(
                    sessionPanelExpandedProvider,
                  ))
                    _SessionPanel(
                      monitoringActive:
                      monitoringActive,
                      sessionCompleted:
                      sessionCompleted,
                      session: session,
                      sessionReady:
                      _sessionReady,
                      sessionNameController:
                      _sessionNameController,
                      pendingSessionName:
                      _pendingSessionName,
                      pendingPatientId:
                      _pendingPatientId,
                      onPendingChanged:
                          (name, patientId) {
                        setState(() {
                          _pendingSessionName =
                              name;
                          _pendingPatientId =
                              patientId;
                          _sessionReady =
                              name != null &&
                                  name.isNotEmpty &&
                                  patientId != null;
                        });
                      },
                    ),
                ],
              ),
            ),


    const SizedBox(height: 8),

// ✅ CALIBRATION / START / STOP BUTTONS
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.start,
                  children: [
                    // ✅ Collect Baseline
                    FilledButton(
                      onPressed: calibrationRunning
                          ? null
                          : () async {
                        try {
                          await CalibrationService(ref)
                              .startCalibration();

                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Baseline collected successfully.',
                                ),
                              ),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text('$e'),
                              ),
                            );
                          }
                        }
                      },
                      child: Text(
                        calibrationRunning
                            ? 'Collecting...'
                            : 'Collect Baseline',
                      ),
                    ),

                //classify button

                    FilledButton(
                      onPressed: classificationRunning ||
                          baseline == null
                          ? null
                          : () async {
                        try {
                          final frameCount =
                          await ClassificationService(ref)
                              .startClassification();

                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Classification complete. '
                                      '$frameCount frames used.',
                                ),
                              ),
                            );

                            Navigator.pushNamed(
                              context,
                              '/position',
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text('$e'),
                              ),
                            );
                          }
                        }
                      },
                      child: Text(
                        classificationRunning
                            ? 'Classifying...'
                            : 'Classify Position',
                      ),
                    ),

                    // if (classificationRunning)
                    //   Text(
                    //     'Classifying (${classificationCountdown}s)',
                    //     style: const TextStyle(
                    //       color: Colors.lightBlue,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),



                    // ✅ Start Monitoring
                    if (!calibration &&
                        patient != null &&
                        session == null &&
                        _sessionReady)
                      FilledButton(
                        onPressed: connected
                            ? () async {
                          final name = _pendingSessionName!;
                          final patientId = _pendingPatientId!;

                          ref
                              .read(
                            monitoringSessionControllerProvider.notifier,
                          )
                              .start(name, patientId);

                          final newSession = ref.read(
                            monitoringSessionControllerProvider,
                          );

                          if (newSession != null) {
                            await FirestoreRepository()
                                .startSession(newSession);
                          }

                          setState(() {
                            _sessionReady = false;
                          });
                        }
                            : null,
                        child: const Text(
                          'Start Monitoring',
                        ),
                      ),



                    // ✅ Stop Monitoring
                    if (monitoringActive)
                      FilledButton(
                        onPressed: () async {
                          final controller = ref.read(
                            monitoringSessionControllerProvider.notifier,
                          );

                          controller.stop();

                          final completedSession = ref.read(
                            monitoringSessionControllerProvider,
                          );

                          if (completedSession != null) {
                            await FirestoreRepository()
                                .stopSession(completedSession);
                          }

                          controller.clear();

                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Monitoring stopped. Session saved.',
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Stop Monitoring',
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 8),

                if (calibrationRunning)
                  Text(
                    'Collecting baseline ($calibrationCountdown s)',
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                if (classificationRunning)
                  Text(
                    'Classifying (${classificationCountdown}s)',
                    style: const TextStyle(
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                if (baseline != null)
                  const Text(
                    'Baseline Ready',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 8),

    const SizedBox(height: 8),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
                children: [

                  // PRESSURE MAP
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/pressure',
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            const Text(
                              'HEAD',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 4),

                            const Expanded(
                              child: PressureGridLarge(
                              ),
                            ),

                            const SizedBox(height: 4),

                            const Text(
                              'FEET',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // POSITION PLACEHOLDER
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/position',
                      );
                    },
                    child: const Card(
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.accessibility_new,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Position',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Coming Soon'),
                        ],
                      ),
                    ),
                  ),

                  // TIME SINCE CHANGE
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/position',
                      );
                    },
                    child: Card(
                      child: Center(
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),

                            Text(
                              'Position Change Timer',
                              style: TextStyle(
                                color: monitoringActive
                                    ? null
                                    : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              monitoringActive
                                  ? '00:00'
                                  : '--',
                              style: TextStyle(
                                color: monitoringActive
                                    ? null
                                    : Colors.grey,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),


                  // PATIENT STATUS
                  Card(
                    child: Center(
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.circle,
                            size: 48,
                            color: monitoringActive
                                ? Colors.green
                                : Colors.grey,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Patient Status',
                            style: TextStyle(
                              color: monitoringActive
                                  ? null
                                  : Colors.grey,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                          Text(
                            monitoringActive
                                ? 'NORMAL'
                                : '--',
                            style: TextStyle(
                              color: monitoringActive
                                  ? null
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}



class _SessionPanel extends ConsumerWidget {
  final bool monitoringActive;
  final bool sessionCompleted;
  final MonitoringSession? session;
  final bool sessionReady;
  final TextEditingController sessionNameController;
  final String? pendingSessionName;
  final String? pendingPatientId;
  final void Function(String? name, String? patientId) onPendingChanged;

  const _SessionPanel({
    super.key,
    required this.monitoringActive,
    required this.sessionCompleted,
    required this.session,
    required this.sessionReady,
    required this.sessionNameController,
    required this.pendingSessionName,
    required this.pendingPatientId,
    required this.onPendingChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientsAsync = ref.watch(patientListProvider);
    final activePatient = ref.watch(activePatientProvider);

    final fieldsEnabled = !monitoringActive;

    final currentSession = session;

    if (sessionNameController.text.isEmpty) {
      if (pendingSessionName != null) {
        sessionNameController.text = pendingSessionName!;
      } else if (currentSession != null &&
          currentSession.sessionName.isNotEmpty) {
        sessionNameController.text = currentSession.sessionName;
      }
    }

    //
    return Card(
      // STEP 2.1 — dark background like Sleep app
      color: const Color(0xFF102539),    // //2.1

      // STEP 2.2 — smooth rounded corners
      shape: RoundedRectangleBorder(      // //2.2
        borderRadius: BorderRadius.circular(16),
      ),

      // STEP 2.3 — remove default white M3 shadows
      elevation: 0,                        // //2.3

      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),

      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // STEP 2.4 — improved title text style (auto from Theme)
            // Text(
            //   'Session Details',
            //   style: Theme.of(context).textTheme.headlineMedium,   // //2.4
            // ),

            const SizedBox(height: 2),

            TextField(
              controller: sessionNameController,
              enabled: fieldsEnabled,
              decoration: InputDecoration(
                labelText: 'Session Name',

                // STEP 2.5 — dark text field styling like your screenshot
                filled: true,                             // //2.5
                fillColor: const Color(0xFF0A1B2A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onChanged: (value) {
                onPendingChanged(
                  value.trim(),
                  pendingPatientId ?? activePatient?.id,
                );
              },
            ),

            const SizedBox(height: 16),

            patientsAsync.when(
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => Text('Error loading patients: $e'),
              data: (patients) {
                final currentId = pendingPatientId ?? activePatient?.id;
                final currentPatient = patients
                    .where((p) => p.id == currentId)
                    .cast<Patient?>()
                    .firstWhere((p) => p != null, orElse: () => null);


                //   initialValue: currentPatient,
                //   decoration: InputDecoration(
                //     labelText: 'Patient',
                //
                //     // STEP 2.6 — dark dropdown background
                //     filled: true,                             // //2.6
                //     fillColor: const Color(0xFF0A1B2A),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //   ),
                  // items: patients
                  //     .map(
                  //       (p) => DropdownMenuItem<Patient>(
                  //     value: p,
                  //     child: Text(p.name),
                  //   ),
                  // )
                  //     .toList(),

                //   onChanged: fieldsEnabled
                //       ? (p) {
                //     if (p == null) return;
                //     ref.read(activePatientProvider.notifier).select(p);
                //     onPendingChanged(
                //       sessionNameController.text.trim(),
                //       p.id,
                //     );
                //   }
                //       : null,
                // );

                return DropdownButtonFormField<Patient?>(
                  initialValue: currentPatient,
                  decoration: InputDecoration(
                    labelText: 'Patient',
                    filled: true,
                    fillColor: const Color(0xFF0A1B2A),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: [
                    const DropdownMenuItem<Patient?>(
                      value: null,
                      child: Text('No active patient'),
                    ),
                    ...patients.map(
                          (p) => DropdownMenuItem<Patient?>(
                        value: p,
                        child: Text(p.name),
                      ),
                    ),
                  ],
                  onChanged: fieldsEnabled
                      ? (p) {
                    if (p == null) {
                      ref.read(activePatientProvider.notifier).clear();
                      onPendingChanged(null, null);
                      return;
                    }

                    ref.read(activePatientProvider.notifier).select(p);
                    onPendingChanged(
                      sessionNameController.text.trim(),
                      p.id,
                    );
                  }
                      : null,
                );

              },
            ),

            const SizedBox(height: 16),

            Text(
              'Date: ${session?.startTime ?? DateTime.now()}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white54,
              ),
            ),

            const SizedBox(height: 20),

            // FilledButton(
            //   onPressed: fieldsEnabled
            //       ? () {
            //     final name = sessionNameController.text.trim();
            //     final patientId = pendingPatientId ?? activePatient?.id;
            //
            //     if (name.isEmpty || patientId == null) {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(
            //           content: Text(
            //               'Please enter a session name and select a patient.'),
            //         ),
            //       );
            //       return;
            //     }
            //
            //     onPendingChanged(name, patientId);
            //
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       const SnackBar(
            //         content: Text(
            //             'Session info saved. You can now start monitoring.'),
            //       ),
            //     );
            //   }
            //       : null,
            //   child: const Text('Save Session'),
            // ),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: fieldsEnabled
                        ? () {
                      final name = sessionNameController.text.trim();
                      final patientId =
                          pendingPatientId ?? activePatient?.id;

                      if (name.isEmpty || patientId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please enter a session name and select a patient.',
                            ),
                          ),
                        );
                        return;
                      }

                      onPendingChanged(name, patientId);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Session info saved. You can now start monitoring.',
                          ),
                        ),
                      );
                    }
                        : null,
                    child: const Text('Save Session'),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: monitoringActive
                      ? FilledButton.icon(
                    icon: const Icon(Icons.stop),
                    label: const Text('Stop'),
                    onPressed: () async {
                      final controller = ref.read(
                        monitoringSessionControllerProvider.notifier,
                      );

                      controller.stop();

                      final completedSession = ref.read(
                        monitoringSessionControllerProvider,
                      );

                      if (completedSession != null) {
                        await FirestoreRepository()
                            .stopSession(completedSession);
                      }

                      controller.clear();

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Monitoring stopped. Session saved.',
                            ),
                          ),
                        );
                      }
                    },
                  )
                      : FilledButton.icon(
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Start'),
                    onPressed: sessionReady
                        ? () async {
                      final name =
                      sessionNameController.text.trim();

                      final patientId =
                          pendingPatientId ??
                              activePatient?.id;

                      if (name.isEmpty ||
                          patientId == null) {
                        return;
                      }

                      ref
                          .read(
                        monitoringSessionControllerProvider
                            .notifier,
                      )
                          .start(
                        name,
                        patientId,
                      );

                      final newSession = ref.read(
                        monitoringSessionControllerProvider,
                      );

                      if (newSession != null) {
                        await FirestoreRepository()
                            .startSession(newSession);
                      }

                      if (context.mounted) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Monitoring started.',
                            ),
                          ),
                        );
                      }
                    }
                        : null,),
                  ),
              ],
            ),
          ],
        ),
      ),
    );

  }
}



const List<int> sensorLayout = [
  8, 7, 6, 5,
  10, 9, 4, 3,
  12, 11, 2, 1,
  20, 19, 18, 17,
  22, 21, 16, 15,
  24, 23, 14, 13,
  32, 31, 30, 29,
  34, 33, 28, 27,
  36, 35, 26, 25,
];

// [
// 5,  3,  1,  17,  15,  13,  29,  27, 25,
// 6,  4,  2,  18,  16,  14,  30,  28, 26,
// 7,  9,  11, 19,  21,  23,  31,  33, 35,
// 8,  10, 12, 20,  22,  24,  32,  34, 36 ];


// class PressureThresholds {
//   static const double low = 30_000;    // 40.00 kΩ
//   static const double medium = 48_000; // 55.00 kΩ
//   static const double high = 60_000;   // 70.00 kΩ
// }
//later load from firestore and adjst per patient




class PressureGridLarge extends ConsumerWidget {
  const PressureGridLarge({super.key});

  // Color _valueToColor(double v) {
  //   if (v < PressureThresholds.low) {
  //     return Colors.blue.shade300;
  //   }
  //   if (v < PressureThresholds.medium) {
  //     return Colors.green.shade400;
  //   }
  //   if (v < PressureThresholds.high) {
  //     return Colors.yellow.shade600;
  //   }
  //   return Colors.red.shade600;
  // }


  Color _valueToColor(double n) {
    n = n.clamp(0.0, 2.0);

    if (n < 0.10) {
      return Colors.green.shade500;
    }

    if (n < 0.30) {
      return Colors.teal.shade700;
    }

    if (n < 0.60) {
      return Colors.teal.shade900;
    }

    if (n < 1.00) {
      return Colors.yellow.shade700;
    }

    if (n < 1.50) {
      return Colors.orange.shade700;
    }

    return Colors.red.shade700;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sensorValues = ref.watch(latestSensorValuesProvider);

    final baseline =  ref.watch(baselineFrameProvider);

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

        crossAxisCount: 4,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
        childAspectRatio: 4.5,

      ),
      itemCount: sensorLayout.length,
      itemBuilder: (context, index) {
        final sensorNumber = sensorLayout[index];
        // final value = sensorValues[sensorNumber] ?? 0.0;
        // final color = _valueToColor(value);

        // final value =
        //     sensorValues[sensorNumber] ?? 0.0;

        final value =
        baseline == null
            ? 0.0
            : (sensorValues[sensorNumber] ?? 0.0);

        double normalized = 0.0;

        if (
        baseline != null &&
            baseline.length == 210
        ) {
          final baselineValue =
          baseline[sensorNumber - 1];

          if (baselineValue > 0) {
            normalized =
                (value - baselineValue) /
                    baselineValue;
          }
        }

        final color =
        _valueToColor(normalized);

        return LayoutBuilder(
          builder: (context, constraints) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  // ✅ SENSOR NUMBER (TOP-LEFT BADGE)
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'S$sensorNumber',
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),

                  // ✅ VALUE (CENTER, AUTO-SCALING)
                  // Center(
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 6),
                  //     child: FittedBox(
                  //       fit: BoxFit.scaleDown,
                  //       child: Text(
                  //         formatKOhms(value),
                  //         textAlign: TextAlign.center,
                  //         style: const TextStyle(
                  //           fontSize: 28, // base size, will scale down
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        formatNormalized(normalized),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 8.4, // ✅ visibly larger
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            );
          },
        );
      },
    );
  }

  String formatNormalized(
      double value,
      ) {
    return '+${(value * 100).toStringAsFixed(0)}%';
  }

  // String formatValue(double v) {
  //   if (v >= 10000) {
  //     return '${(v / 1000).toStringAsFixed(1)}k';
  //   }
  //   if (v >= 1000) {
  //     return v.toStringAsFixed(0);
  //   }
  //   return v.toStringAsFixed(1);
  // }
  //
  // String formatKOhms(double rawOhms) {
  //   final kOhms = rawOhms / 1000.0;
  //   return '${kOhms.toStringAsFixed(2)} kΩ';
  // }


//   Color _valueToColor(double v) {
//     if (v < 10) return Colors.blue.shade300;
//     if (v < 20) return Colors.green.shade400;
//     if (v < 30) return Colors.yellow.shade600;
//     return Colors.red.shade600;
//   }
}
class _PositionPreview extends StatelessWidget {
  const _PositionPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Icon(
          Icons.accessibility_new,
          size: 120,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }
}

