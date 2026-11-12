// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../models/patient.dart';
// import '../state/patient_providers.dart';
// import 'home_page.dart';
//
// class PatientPage extends ConsumerStatefulWidget {
//   final Patient? patient;
//
//   const PatientPage({super.key, required this.patient});
//
//   @override
//   ConsumerState<PatientPage> createState() => _PatientPageState();
// }
//
// class _PatientPageState extends ConsumerState<PatientPage> {
//   late TextEditingController _name;
//   late TextEditingController _height;
//   late TextEditingController _weight;
//
//   @override
//   void initState() {
//     super.initState();
//     _name = TextEditingController(text: widget.patient?.name ?? '');
//     _height = TextEditingController(
//         text: widget.patient?.height?.toString() ?? '');
//     _weight = TextEditingController(
//         text: widget.patient?.weight?.toString() ?? '');
//   }
//
//   @override
//   void dispose() {
//     _name.dispose();
//     _height.dispose();
//     _weight.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isNew = widget.patient == null;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(isNew ? 'New Patient' : 'Edit Patient'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           children: [
//             TextField(
//               controller: _name,
//               decoration: const InputDecoration(labelText: 'Name'),
//             ),
//             TextField(
//               controller: _height,
//               decoration: const InputDecoration(labelText: 'Height (cm)'),
//               keyboardType: TextInputType.number,
//             ),
//             TextField(
//               controller: _weight,
//               decoration: const InputDecoration(labelText: 'Weight (kg)'),
//               keyboardType: TextInputType.number,
//             ),
//             const Spacer(),
//             FilledButton(
//               onPressed: () {
//                 final p = Patient(
//                   id: widget.patient?.id ??
//                       DateTime.now().millisecondsSinceEpoch.toString(),
//                   name: _name.text.trim(),
//                   height: double.tryParse(_height.text),
//                   weight: double.tryParse(_weight.text),
//                 );
//
//                 ref.read(activePatientProvider.notifier).select(p);
//
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (_) => const HomePage()),
//                       (route) => false,
//                 );
//               },
//               child: const Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../models/patient.dart';
// import '../state/patient_providers.dart';
// import '../state/patient_repository_provider.dart';
// import 'home_page.dart';
//
// class PatientPage extends ConsumerStatefulWidget {
//   final Patient? patient;
//
//   const PatientPage({super.key, required this.patient});
//
//   @override
//   ConsumerState<PatientPage> createState() => _PatientPageState();
// }
//
// class _PatientPageState extends ConsumerState<PatientPage> {
//   late TextEditingController _name;
//   late TextEditingController _height;
//   late TextEditingController _weight;
//
//   @override
//   void initState() {
//     super.initState();
//     _name = TextEditingController(text: widget.patient?.name ?? '');
//     _height = TextEditingController(
//         text: widget.patient?.height?.toString() ?? '');
//     _weight = TextEditingController(
//         text: widget.patient?.weight?.toString() ?? '');
//   }
//
//   @override
//   void dispose() {
//     _name.dispose();
//     _height.dispose();
//     _weight.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isNew = widget.patient == null;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(isNew ? 'New Patient' : 'Edit Patient'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           children: [
//             TextField(
//               controller: _name,
//               decoration: const InputDecoration(labelText: 'Name'),
//             ),
//             TextField(
//               controller: _height,
//               decoration: const InputDecoration(labelText: 'Height (cm)'),
//               keyboardType: TextInputType.number,
//             ),
//             TextField(
//               controller: _weight,
//               decoration: const InputDecoration(labelText: 'Weight (kg)'),
//               keyboardType: TextInputType.number,
//             ),
//             const Spacer(),
//             FilledButton(
//               onPressed: () async {
//                 final nav = Navigator.of(context);
//
//                 final p = Patient(
//                   id: widget.patient?.id ??
//                       DateTime.now().millisecondsSinceEpoch.toString(),
//                   name: _name.text.trim(),
//                   height: double.tryParse(_height.text),
//                   weight: double.tryParse(_weight.text),
//                 );
//
//                 // 1. Save to Firestore
//                 await ref
//                     .read(patientRepositoryProvider.notifier)
//                     .savePatient(p);
//
//                 // 2. Update active patient
//                 ref.read(activePatientProvider.notifier).select(p);
//
//                 // 3. Refresh patient list
//                 ref.invalidate(patientListProvider);
//
//                 // 4. Navigate safely
//                 nav.pushAndRemoveUntil(
//                   MaterialPageRoute(builder: (_) => const HomePage()),
//                       (_) => false,
//                 );
//               },
//               child: const Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../models/patient.dart';
// import '../state/patient_providers.dart';
// import '../state/patient_repository_provider.dart';
// import '../state/mqtt_connection_provider.dart';
// import '../widgets/app_scaffold.dart';
//
//
// class PatientPage extends ConsumerStatefulWidget {
//   const PatientPage({super.key});
//
//   @override
//   ConsumerState<PatientPage> createState() => _PatientPageState();
// }
//
// class _PatientPageState extends ConsumerState<PatientPage> {
//   Patient? selectedPatient;
//   bool creatingNew = false;
//
//   late TextEditingController _name;
//   late TextEditingController _height;
//   late TextEditingController _weight;
//
//   @override
//   void initState() {
//     super.initState();
//     _name = TextEditingController();
//     _height = TextEditingController();
//     _weight = TextEditingController();
//   }
//
//   void loadPatient(Patient p) {
//     selectedPatient = p;
//     creatingNew = false;
//
//     _name.text = p.name;
//     _height.text = p.height?.toString() ?? '';
//     _weight.text = p.weight?.toString() ?? '';
//
//     setState(() {});
//   }
//
//   void clearForm() {
//     selectedPatient = null;
//     creatingNew = true;
//
//     _name.clear();
//     _height.clear();
//     _weight.clear();
//
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final patientsAsync = ref.watch(patientListProvider);
//     final connected = ref.watch(mqttConnectionProvider);
//
//     return AppScaffold(
//       currentIndex: 1,
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: patientsAsync.when(
//           loading: () => const Center(child: CircularProgressIndicator()),
//           error: (e, _) => Center(child: Text('Error: $e')),
//           data: (patients) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   creatingNew
//                       ? 'Creating New Patient'
//                       : selectedPatient == null
//                       ? 'Select a Patient'
//                       : 'Editing Patient',
//                   style: Theme.of(context).textTheme.headlineSmall,
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // Dropdown
//                 DropdownButtonFormField<Patient>(
//                   initialValue: selectedPatient,
//                   decoration: const InputDecoration(
//                     labelText: 'Select Patient',
//                     border: OutlineInputBorder(),
//                   ),
//                   items: patients.map((p) {
//                     return DropdownMenuItem(
//                       value: p,
//                       child: Text(p.name),
//                     );
//                   }).toList(),
//                   onChanged: (p) {
//                     if (p != null) loadPatient(p);
//                   },
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // New Patient button
//                 FilledButton(
//                   onPressed: clearForm,
//                   child: const Text('New Patient'),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // Form
//                 TextField(
//                   controller: _name,
//                   decoration: const InputDecoration(labelText: 'Name'),
//                 ),
//                 const SizedBox(height: 12),
//                 TextField(
//                   controller: _height,
//                   decoration: const InputDecoration(labelText: 'Height (cm)'),
//                   keyboardType: TextInputType.number,
//                 ),
//                 const SizedBox(height: 12),
//                 TextField(
//                   controller: _weight,
//                   decoration: const InputDecoration(labelText: 'Weight (kg)'),
//                   keyboardType: TextInputType.number,
//                 ),
//
//                 const SizedBox(height: 24),
//
//                 // Save + Delete
//                 Row(
//                   children: [
//                     FilledButton(
//                       onPressed: () async {
//                         final repo =
//                         ref.read(patientRepositoryProvider.notifier);
//
//                         final p = Patient(
//                           id: selectedPatient?.id ??
//                               DateTime.now()
//                                   .millisecondsSinceEpoch
//                                   .toString(),
//                           name: _name.text.trim(),
//                           height: double.tryParse(_height.text),
//                           weight: double.tryParse(_weight.text),
//                         );
//
//                         await repo.savePatient(p);
//                         ref.invalidate(patientListProvider);
//
//                         selectedPatient = p;
//                         creatingNew = false;
//
//                         ref
//                             .read(activePatientProvider.notifier)
//                             .select(p);
//
//                         setState(() {});
//                       },
//                       child: const Text('Save'),
//                     ),
//                     const SizedBox(width: 12),
//                     if (selectedPatient != null)
//                       FilledButton(
//                         style: FilledButton.styleFrom(
//                           backgroundColor: Colors.red,
//                         ),
//                         onPressed: () async {
//                           final repo =
//                           ref.read(patientRepositoryProvider.notifier);
//
//                           await repo.deletePatient(selectedPatient!.id);
//                           ref.invalidate(patientListProvider);
//
//                           selectedPatient = null;
//                           creatingNew = true;
//
//                           ref
//                               .read(activePatientProvider.notifier)
//                               .clear();
//
//                           clearForm();
//                         },
//                         child: const Text('Delete'),
//                       ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 24),
//
//                 // Start Monitoring
//                 FilledButton(
//                   onPressed: selectedPatient != null && connected
//                       ? () {
//                     Navigator.pushReplacementNamed(
//                         context, '/monitoring');
//                   }
//                       : null,
//                   child: const Text('Start Monitoring'),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/patient.dart';
import '../state/patient_providers.dart';
import '../state/mqtt_connection_provider.dart';
import '../widgets/app_scaffold.dart';
import 'patient_form_page.dart';
import '../widgets/app_title.dart';
import '../state/monitoring_session_provider.dart';

// class PatientSelectionPage extends ConsumerWidget {
//   const PatientSelectionPage({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final patientsAsync = ref.watch(patientListProvider);
//     final activePatient = ref.watch(activePatientProvider);
//     final connected = ref.watch(mqttConnectionProvider);
//
//     return AppScaffold(
//       currentIndex: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: patientsAsync.when(
//           loading: () => const Center(child: CircularProgressIndicator()),
//           error: (e, _) => Center(child: Text('Error: $e')),
//           data: (patients) {
//             return Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Select Patient',
//                   style: Theme.of(context).textTheme.headlineSmall,
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 DropdownButtonFormField<Patient>(
//                   value: patients.firstWhere(
//                         (p) => p.id == activePatient?.id,
//                     orElse: () => null,
//                   ),
//                   decoration: const InputDecoration(
//                     labelText: 'Patient',
//                     border: OutlineInputBorder(),
//                   ),
//                   items: patients
//                       .map(
//                         (p) => DropdownMenuItem<Patient>(
//                       value: p,
//                       child: Text(p.name),
//                     ),
//                   )
//                       .toList(),
//                   onChanged: (p) {
//                     if (p != null) {
//                       ref.read(activePatientProvider.notifier).select(p);
//                     }
//                   },
//                 ),
                // DropdownButtonFormField<Patient>(
                //   initialValue: activePatient,
                //   decoration: const InputDecoration(
                //     labelText: 'Patient',
                //     border: OutlineInputBorder(),
                //   ),
                //   items: patients
                //       .map((p) => DropdownMenuItem(
                //     value: p,
                //     child: Text(p.name),
                //   ))
                //       .toList(),
                //   onChanged: (p) {
                //     if (p != null) {
                //       ref.read(activePatientProvider.notifier).select(p);
                //     }
                //   },
                // ),

//                 const SizedBox(height: 20),
//
//                 FilledButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => const PatientFormPage(),
//                       ),
//                     );
//                   },
//                   child: const Text('Create New Patient'),
//                 ),
//
//                 const SizedBox(height: 12),
//
//                 FilledButton(
//                   onPressed: activePatient != null
//                       ? () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) =>
//                             PatientFormPage(patient: activePatient),
//                       ),
//                     );
//                   }
//                       : null,
//                   child: const Text('Edit Selected Patient'),
//                 ),
//
//                 const SizedBox(height: 24),
//
//                 FilledButton(
//                   onPressed: activePatient != null && connected
//                       ? () {
//                     Navigator.pushReplacementNamed(
//                         context, '/home');
//                   }
//                       : null,
//                   child: const Text('Start Monitoring'),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }


class PatientSelectionPage extends ConsumerWidget {
  const PatientSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientsAsync = ref.watch(patientListProvider);
    final activePatient = ref.watch(activePatientProvider);
    final connected = ref.watch(mqttConnectionProvider);

    return AppScaffold(
      currentIndex: 2,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: patientsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (patients) {

            final Patient? selectedPatient = patients
                .where((p) => p.id == activePatient?.id)
                .cast<Patient?>()
                .firstOrNull; // this becomes null if no match

            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'Select Patient',
                  //   style: Theme.of(context).textTheme.headlineSmall,
                  // ),
                  const AppTitle('Select Patient'),

                  const SizedBox(height: 20),


                  DropdownButtonFormField<Patient?>(
                    initialValue: selectedPatient,        // <-- safe nullable value
                    decoration: const InputDecoration(
                      labelText: 'Patient',
                      border: OutlineInputBorder(),
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

                    // items: patients
                    //     .map(
                    //       (p) => DropdownMenuItem<Patient>(
                    //     value: p,
                    //     child: Text(p.name),
                    //   ),
                    // )
                    //     .toList(),

                    // Update the provider on change
                  //   onChanged: (p) {
                  //     if (p != null) {
                  //       ref.read(activePatientProvider.notifier).select(p);
                  //     }
                  //   },

                      onChanged: (p) async {
                        if (p == null) {
                          // ✅ Clear patient and any active session
                          ref.read(activePatientProvider.notifier).clear();
                          ref.read(activePatientAlarmSettingsProvider.notifier).clear();
                          ref.read(monitoringSessionControllerProvider.notifier).clear();
                          return;
                        }

                        // ✅ Normal selection
                        ref
                            .read(activePatientProvider.notifier)
                            .select(p);

                        await ref
                            .read(
                          activePatientAlarmSettingsProvider
                              .notifier,
                        )
                            .load(p.id);
                      },


                   ),






                  const SizedBox(height: 20),

                  FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PatientFormPage(),
                        ),
                      );
                    },
                    child: const Text('Create New Patient'),
                  ),

                  const SizedBox(height: 12),

                  FilledButton(
                    onPressed: activePatient != null
                        ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              PatientFormPage(patient: activePatient),
                        ),
                      );
                    }
                        : null,
                    child: const Text('Edit Selected Patient'),
                  ),

                  const SizedBox(height: 24),

                  FilledButton(
                    onPressed: activePatient != null && connected
                        ? () {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                        : null,
                    child: const Text('Start Monitoring'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

extension FirstOrNullExtension<E> on Iterable<E> {
  E? get firstOrNull => isEmpty ? null : first;
}
