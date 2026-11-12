import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/patient.dart';
import '../state/patient_providers.dart';
import '../state/patient_repository_provider.dart';
import 'alarm_settings_page.dart';

class PatientFormPage extends ConsumerStatefulWidget {
  final Patient? patient;

  const PatientFormPage({super.key, this.patient});

  @override
  ConsumerState<PatientFormPage> createState() => _PatientFormPageState();
}

class _PatientFormPageState extends ConsumerState<PatientFormPage> {
  late TextEditingController _name;
  late TextEditingController _height;
  late TextEditingController _weight;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.patient?.name ?? '');
    _height = TextEditingController(
        text: widget.patient?.height?.toString() ?? '');
    _weight = TextEditingController(
        text: widget.patient?.weight?.toString() ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final repo = ref.read(patientRepositoryProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.patient == null
            ? 'Create Patient'
            : 'Edit Patient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _name,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _height,
              decoration: const InputDecoration(labelText: 'Height (cm)', border: OutlineInputBorder(),),
              keyboardType: TextInputType.number,

            ),
            const SizedBox(height: 12),
            TextField(
              controller: _weight,
              decoration: const InputDecoration(labelText: 'Weight (kg)', border: OutlineInputBorder(),),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 12),

            // TextFormField(
            //   readOnly: true,
            //   decoration: const InputDecoration(
            //     labelText: 'Alarm Settings',
            //     border: OutlineInputBorder(),
            //     suffixIcon: Icon(
            //       Icons.chevron_right,
            //     ),
            //   ),
            //   onTap: widget.patient == null
            //       ? null
            //       : () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (_) => AlarmSettingsPage(
            //           patient: widget.patient,
            //         ),
            //       ),
            //     );
            //   },
            // ),

            Card(
              child: ListTile(
                title: const Text('Alarm Settings'),
                subtitle: const Text(
                  'Configure thresholds and sensitivity',
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AlarmSettingsPage(
                        patient: widget.patient,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            FilledButton(
              onPressed: () async {
                final p = Patient(
                  id: widget.patient?.id ??
                      DateTime.now()
                          .millisecondsSinceEpoch
                          .toString(),
                  name: _name.text.trim(),
                  height: double.tryParse(_height.text),
                  weight: double.tryParse(_weight.text),
                );

                await repo.savePatient(p);
                ref.invalidate(patientListProvider);

                // Re-select the real instance from Firestore
                final updatedList =
                await ref.read(patientListProvider.future);
                final realInstance =
                updatedList.firstWhere((x) => x.id == p.id);

                ref
                    .read(activePatientProvider.notifier)
                    .select(realInstance);

                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),

            if (widget.patient != null) ...[
              const SizedBox(height: 12),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () async {
                  await repo.deletePatient(widget.patient!.id);
                  ref.invalidate(patientListProvider);
                  ref.read(activePatientProvider.notifier).clear();
                  Navigator.pop(context);
                },
                child: const Text('Delete'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
