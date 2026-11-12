import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../widgets/app_scaffold.dart';
import '../widgets/app_title.dart';
import '../models/patient.dart';
import '../models/session.dart';
import '../state/session_providers.dart';
import '../state/patient_providers.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientsAsync = ref.watch(patientListProvider);

    return AppScaffold(
      currentIndex: 5,
      appBar: AppBar(
        title: const AppTitle('History'),
      ),
      child: patientsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (patients) {
          if (patients.isEmpty) {
            return const Center(child: Text('No patients'));
          }

          return ListView(
            children: patients
                .map((p) => _PatientHistoryTile(patient: p))
                .toList(),
          );
        },
      ),
    );
  }
}

class _PatientHistoryTile extends ConsumerWidget {
  final Patient patient;

  const _PatientHistoryTile({required this.patient});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync =
    ref.watch(sessionHistoryProvider(patient.id));

    return ExpansionTile(
      title: Text(patient.name),
      children: [
        sessionsAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(8),
            child: CircularProgressIndicator(),
          ),
          error: (e, _) => const ListTile(
            title: Text('Error loading sessions'),
          ),
          data: (sessions) {
            if (sessions.isEmpty) {
              return const ListTile(
                title: Text('No completed sessions'),
              );
            }

            return Column(
              children: sessions
                  .map(
                    (s) => _SessionHistoryTile(
                  patient: patient,
                  session: s,
                ),
              )
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}

class _SessionHistoryTile extends StatelessWidget {
  final Patient patient;
  final Session session;

  const _SessionHistoryTile({
    required this.patient,
    required this.session,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(session.sessionName ?? 'Unnamed session'),
      subtitle: Text(
        '${session.startTime} → ${session.endTime}',
        style: const TextStyle(fontSize: 12),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.download),
        tooltip: 'Export CSV',
        onPressed: () async {
          await exportSessionToCsvWide(
            context: context,
            patient: patient,
            session: session,
          );
        },
      ),
    );
  }
}

// Future<void> exportSessionToCsvWide({
//   required Patient patient,
//   required Session session,
// }) async {
//   final firestore = FirebaseFirestore.instance;
//
//   // timestamp → sensor → value (kΩ)
//   final Map<DateTime, Map<int, double>> table = {};
//
//   final sensorsSnap = await firestore
//       .collection('patients')
//       .doc(patient.id)
//       .collection('sessions')
//       .doc(session.id)
//       .collection('sensors')
//       .get();
//
//   for (final sensorDoc in sensorsSnap.docs) {
//     final sensorNumber = int.parse(sensorDoc.id);
//
//     final readingsSnap = await sensorDoc.reference
//         .collection('readings')
//         .orderBy('timestamp')
//         .get();
//
//     for (final r in readingsSnap.docs) {
//       final ts = (r['timestamp'] as Timestamp).toDate();
//       final valueOhms = (r['value'] as num).toDouble();
//       final valueKOhms = valueOhms / 1000.0;
//
//       table.putIfAbsent(ts, () => {});
//       table[ts]![sensorNumber] = valueKOhms;
//     }
//   }
//
//   final sensors = List.generate(35, (i) => i + 1);
//
//   final rows = <List<String>>[];
//   rows.add([
//     'timestamp',
//     ...sensors.map((s) => 'S$s'),
//   ]);
//
//   final times = table.keys.toList()..sort();
//
//   for (final ts in times) {
//     final row = <String>[ts.toUtc().toIso8601String()];
//     for (final s in sensors) {
//       row.add(table[ts]![s]?.toStringAsFixed(2) ?? '');
//     }
//     rows.add(row);
//   }
//
//   final csv = const ListToCsvConverter().convert(rows);
//
//   final dir = await getTemporaryDirectory();
//   final file = File(
//     '${dir.path}/${patient.name}_${session.sessionName ?? session.id}.csv',
//   );
//
//   await file.writeAsString(csv);
//
//   await Share.shareXFiles(
//     [XFile(file.path)],
//     text: 'Session export: ${session.sessionName}',
//   );
// }

Future<void> exportSessionToCsvWide({
  required BuildContext context,
  required Patient patient,
  required Session session,
}) async {
  final firestore = FirebaseFirestore.instance;

  // timestamp → sensor → value (kΩ)
  final Map<DateTime, Map<int, double>> table = {};

  final sensorsSnap = await firestore
      .collection('patients')
      .doc(patient.id)
      .collection('Printed_sessions')
      .doc(session.id)
      .collection('sensors')
      .get();

  for (final sensorDoc in sensorsSnap.docs) {
    final sensorNumber = int.parse(sensorDoc.id);

    final readingsSnap = await sensorDoc.reference
        .collection('readings')
        .orderBy('timestamp')
        .get();

    for (final r in readingsSnap.docs) {
      final ts = (r['timestamp'] as Timestamp).toDate();
      final valueOhms = (r['value'] as num).toDouble();
      final valueKOhms = valueOhms / 1000.0;

      table.putIfAbsent(ts, () => {});
      table[ts]![sensorNumber] = valueKOhms;
    }
  }

  final sensors = List.generate(35, (i) => i + 1);

  final rows = <List<String>>[];
  rows.add([
    'timestamp',
    ...sensors.map((s) => 'S$s'),
  ]);

  final times = table.keys.toList()..sort();

  for (final ts in times) {
    final row = <String>[ts.toUtc().toIso8601String()];
    for (final s in sensors) {
      row.add(table[ts]![s]?.toStringAsFixed(2) ?? '');
    }
    rows.add(row);
  }

  final csv = const ListToCsvConverter().convert(rows);

  // SAVE TO USER-VISIBLE DOWNLOADS DIRECTORY
  final downloadsDir = await getDownloadsDirectory();
  if (downloadsDir == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Unable to access Downloads folder')),
    );
    return;
  }

  final fileName =
  '${patient.name}_${session.sessionName ?? session.id}.csv'
      .replaceAll(' ', '_');

  final file = File('${downloadsDir.path}/$fileName');
  await file.writeAsString(csv);

  //CONFIRM TO USER
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('CSV saved to Downloads:\n$fileName'),
      duration: const Duration(seconds: 4),
    ),
  );
}