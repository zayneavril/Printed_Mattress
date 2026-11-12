

import 'package:first_app/widgets/app_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/patient_providers.dart';
import '../state/mqtt_connection_provider.dart';
//import 'patient_page.dart';
//import 'home_page.dart';
import '../widgets/app_scaffold.dart';
import '../data/services/calibration_service.dart';
import '../state/classification_providers.dart';



// class StartPage extends ConsumerWidget {
//   const StartPage({super.key});
//

class StartPage extends ConsumerStatefulWidget {
  const StartPage({super.key});

  @override
  ConsumerState<StartPage> createState() =>
      _StartPageState();
}

class _StartPageState
    extends ConsumerState<StartPage> {

  //static bool _baselinePromptShown = false;
    static bool _baselinePromptShown = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      _showBaselineDialogIfNeeded();
    });
  }
  Future<void> _showBaselineDialogIfNeeded() async {
    if (_baselinePromptShown) return;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final connected =
        ref.watch(mqttConnectionProvider);

        final calibrationRunning =
        ref.watch(calibrationRunningProvider);

        final countdown =
        ref.watch(calibrationCountdownProvider);

        final frameCount =
            ref.watch(calibrationFramesProvider).length;

        return PopScope(
          canPop: false,
          child: AlertDialog(
            title: const Text(
              'Baseline Required',
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const Text(
                  'Collect a baseline before you begin.',
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Icon(
                      connected
                          ? Icons.circle
                          : Icons.circle_outlined,
                      size: 12,
                      color: connected
                          ? Colors.green
                          : Colors.red,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      connected
                          ? 'MQTT Connected'
                          : 'MQTT Disconnected',
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                if (calibrationRunning) ...[
                  const SizedBox(height: 12),
                  Text(
                    'Collecting baseline ($countdown s)',
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
            actions: [
              FilledButton(
                onPressed:
                !connected
                    ? null
                    : () {
                  _baselinePromptShown = true;

                  Navigator.pop(context);

                  Navigator.pushReplacementNamed(
                    context,
                    '/home',
                  );
                },
                child: Text(
                  calibrationRunning
                      ? 'Collecting...'
                      : 'OK',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final patientsAsync = ref.watch(patientListProvider);
    final connected = ref.watch(mqttConnectionProvider);
    print('🔌 UI sees MQTT connected = $connected');


//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Start'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: patientsAsync.when(
//           loading: () => const Center(child: CircularProgressIndicator()),
//           error: (e, _) => Center(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text('Error loading patients: $e'),
//                 const SizedBox(height: 12),
//                 FilledButton(
//                   onPressed: () {
//                     ref.invalidate(patientListProvider);
//                   },
//                   child: const Text('Retry'),
//                 ),
//               ],
//             ),
//           ),
//           data: (patients) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // MQTT status
//                 Row(
//                   children: [
//                     Icon(
//                       connected ? Icons.circle : Icons.circle_outlined,
//                       color: connected ? Colors.green : Colors.red,
//                       size: 14,
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       connected ? 'MQTT Connected' : 'MQTT Disconnected',
//                       style: TextStyle(
//                         color: connected ? Colors.green : Colors.red,
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 40),
//
//                 // Calibration Mode
//                 FilledButton(
//                   onPressed: connected
//                       ? () {
//                     Navigator.pushReplacementNamed(context, '/home');
//                   }
//                       : null,
//                   child: const Text('Calibration Mode'),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // Select / Create Patient
//                 FilledButton(
//                   onPressed: () {
//                     Navigator.pushReplacementNamed(context, '/patients');
//                   },
//                   child: const Text('Select / Create Patient'),
//                 ),
//
//                 const Spacer(),
//
//                 // Debug count
//                 Text(
//                   'Patients in database: ${patients.length}',
//                   style: TextStyle(
//                     color: Colors.grey.shade600,
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }


    return AppScaffold(
    currentIndex: 0,
    appBar: AppBar(
      title: const AppTitle('Start'),
    ),
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: patientsAsync.when(
        loading: () =>
        const Center(child: CircularProgressIndicator()),

        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Error loading patients: $e'),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () {
                  ref.invalidate(patientListProvider);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),

        data: (patients) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // MQTT status
              Row(
                children: [
                  Icon(
                    connected ? Icons.circle : Icons.circle_outlined,
                    color: connected ? Colors.green : Colors.red,
                    size: 14,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    connected ? 'MQTT Connected' : 'MQTT Disconnected',
                    style: TextStyle(
                      color: connected ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Calibration Mode
              FilledButton(
                onPressed: connected
                    ? () {
                  Navigator.pushReplacementNamed(
                      context, '/home');
                }
                    : null,
                child: const Text('Calibration Mode'),
              ),

              const SizedBox(height: 20),

              // Select / Create Patient
              FilledButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, '/patients');
                },
                child: const Text('Select / Create Patient'),
              ),

              const Spacer(),

              // Debug count
              Text(
                'Patients in database: ${patients.length}',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          );
        },
      ),
    ),
    );
  }
}
