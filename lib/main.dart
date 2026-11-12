// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:firebase_core/firebase_core.dart';
//
// import 'pages/start_page.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   runApp(
//     const ProviderScope(
//       child: MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Pressure Monitoring Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorSchemeSeed: Colors.blue,
//         useMaterial3: true,
//       ),
//       home: const StartPage(),
//     );
//   }
// }

import 'package:first_app/pages/history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

import 'pages/start_page.dart';
import 'pages/patient_page.dart';
import 'pages/home_page.dart';
import 'pages/position_page.dart';
import 'pages/pressure_map_page.dart';
import 'pages/settings_page.dart';
//import 'pages/history_page.dart';
import 'state/mqtt_connection_provider.dart';
import 'state/mqtt_client_manager_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Pressure Monitoring Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         brightness: Brightness.dark,                                // A dark theme base
//         scaffoldBackgroundColor: const Color(0xFF0A1B2A),           // Deep navy blue
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color(0xFF4CC2F1),                       // Cyan/Teal accent
//           brightness: Brightness.dark,
//         ),
//         useMaterial3: true,
//
//         textTheme: const TextTheme(
//           headlineMedium: TextStyle(                                // Titles
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//           bodyMedium: TextStyle(                                    // Body text
//             fontSize: 16,
//             color: Colors.white70,
//           ),
//         ),
//       ),
// ,
//
//       // NEW: Use named routes
//       initialRoute: '/start',
//
//       routes: {
//         '/start': (_) => const StartPage(),
//         '/patients': (_) => const PatientSelectionPage(),
//         '/home': (_) => const HomePage(),
//         '/position': (_) => const PositionPage(),
//         '/pressure': (_) => const PressureMapPage(),
//         '/settings': (_) => const SettingsPage(),
//         //'/history': (_) => const HistoryPage(),
//       },
//     );
//   }
// }


class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  bool _connectedOnce = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_connectedOnce) {
      _connectedOnce = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(mqttClientManagerProvider).connect(
          broker: '192.168.43.184',//ip of laptop on phone hotspot.  '10.0.2.2', -ip of laptop Mosquitto (emulator -> host)
          clientId: 'flutter_${DateTime.now().millisecondsSinceEpoch}',
        );

        // // Explicitly start as disconnected until callback fires
        // ref.read(mqttConnectionProvider.notifier).setConnected(false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pressure Monitoring Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A1B2A),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CC2F1),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ),
      initialRoute: '/start',
      routes: {
        '/start': (_) => const StartPage(),
        '/patients': (_) => const PatientSelectionPage(),
        '/home': (_) => const HomePage(),
        '/position': (_) => const PositionPage(),
        '/pressure': (_) => const PressureMapPage(),
        '/history' : (_) => const HistoryPage(),
        '/settings': (_) => const SettingsPage(),
      },
    );
  }
}
