import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/patient_providers.dart';
import '../state/mqtt_connection_provider.dart';
import '../state/calibration_providers.dart';

class AppScaffold extends ConsumerWidget {
  final Widget child;
  final int currentIndex;
  final PreferredSizeWidget? appBar;

  const AppScaffold({
    super.key,
    required this.child,
    required this.currentIndex,
    this.appBar,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activePatient = ref.watch(activePatientProvider);
    final connected = ref.watch(mqttConnectionProvider);
    print('🔁 AppScaffold rebuild — MQTT connected = $connected');
    final calibration = ref.watch(calibrationModeProvider);

    // Tab access rules
    final canAccessPatients = activePatient != null || !calibration;
    final canAccessPosition = activePatient != null && !calibration;
    final canAccessPressure = activePatient != null && !calibration;

    return Scaffold(
      appBar: appBar,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: child,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewPadding.bottom,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
            onTap: (i) {
              switch (i) {
                case 0:
                  Navigator.pushReplacementNamed(context, '/start');
                  break;
                case 1:
                  Navigator.pushReplacementNamed(context, '/home');
                  break;
                case 2:
                  if (canAccessPatients) {
                    Navigator.pushReplacementNamed(context, '/patients');
                  }
                  break;
                case 3:
                  if (canAccessPosition) {
                    Navigator.pushReplacementNamed(context, '/position');
                  }
                  break;
                case 4:
                  if (canAccessPressure) {
                    Navigator.pushReplacementNamed(context, '/pressure');
                  }
                  break;
                case 5:
                  Navigator.pushReplacementNamed(context, '/history');
                  break;
                case 6:
                  Navigator.pushReplacementNamed(context, '/settings');
                  break;
              }
            },
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Start',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
                color: canAccessPatients ? null : Colors.grey,
              ),
              label: 'Patients',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.accessibility_new,
                color: canAccessPosition ? null : Colors.grey,
              ),
              label: 'Position',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.grid_view,
                color: canAccessPressure ? null : Colors.grey,
              ),
              label: 'Pressure',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}