// import 'package:first_app/widgets/app_title.dart';
// import 'package:flutter/material.dart';
// import '../widgets/app_scaffold.dart';
//
// class PressureMapPage extends StatelessWidget {
//   const PressureMapPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return AppScaffold(
//       currentIndex: 4, // Pressure tab
//       appBar: AppBar(title: const AppTitle('Pressure Map')),
//       child: const Center(
//         child: Text('Pressure Map Page'),
//       ),
//     );
//   }
// }
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:first_app/state/classification_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'home_page.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/app_title.dart';
//import '../models/sensor_readings.dart';
import '../state/monitoring_providers.dart';
import '../data/services/calibration_service.dart';

// class PressureMapPage extends ConsumerWidget {
//   const PressureMapPage({super.key});

class PressureMapPage extends ConsumerStatefulWidget {
  const PressureMapPage({super.key});

  @override
  ConsumerState<PressureMapPage> createState() =>
      _PressureMapPageState();
}

class _PressureMapPageState
    extends ConsumerState<PressureMapPage> {

  int _currentPage = 0;


  Widget buildBankGrid(
      int firstSensor,
      Map<int, double> sensorValues,
      List<double>? baseline,
      bool showValues,
      ) {
    return GridView.builder(
      shrinkWrap: true,
      physics:
      const NeverScrollableScrollPhysics(),
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 10,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 1.0,
      ),
      itemCount: 70,
      itemBuilder: (context, index) {

        final row = index ~/ 10;
        final col = index % 10;

        final sensorNumber =
            firstSensor +
                row * 10 +
                (9 - col);

        final value =
            sensorValues[sensorNumber] ??
                0.0;

        double normalized = 0.0;

        if (baseline != null &&
            baseline.length == 210) {

          final baselineValue =
          baseline[sensorNumber - 1];

          if (baselineValue > 0) {
            normalized =
                (value - baselineValue) /
                    baselineValue;
          }
        }

        Color color;

        if (normalized < 0.20) {
          color = Colors.green.shade500;
        } else if (normalized < 0.30) {
          color = Colors.teal.shade700;
        } else if (normalized < 0.60) {
          color = Colors.yellow.shade400;
        } else if (normalized < 1.00) {
          color = Colors.yellow.shade700;
        } else if (normalized < 1.50) {
          color = Colors.orange.shade700;
        } else {
          color = Colors.red.shade700;
        }

        return AnimatedContainer(
          duration:
          const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: color,
            borderRadius:
            BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 6,
                left: 6,
                child: Text(
                  'S$sensorNumber',
                  style: const TextStyle(
                    fontSize: 8,
                    color: Colors.white70,
                  ),
                ),
              ),
              if (showValues)
                Center(
                  child: Text(
                    '+${(normalized * 100).toStringAsFixed(0)}%',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
    final visible = ref.watch(visibleSensorsProvider);
    final frameHistory = ref.watch(frameHistoryProvider);
    final sensorValues =
    ref.watch(latestSensorValuesProvider);
    final baseline =
    ref.watch(baselineFrameProvider);

    final calibrationRunning =
    ref.watch(calibrationRunningProvider);

    final countdown =
    ref.watch(calibrationCountdownProvider);

    final frameCount =
        ref.watch(calibrationFramesProvider).length;

    final showValues =
    ref.watch(showPressureValuesProvider);

    return AppScaffold(
      currentIndex: 4,
      appBar: AppBar(
        title: const AppTitle('Pressure Map'),
      ),
      child: Column(
        children: [

          Row(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration:
                const Duration(milliseconds: 200),
                width: _currentPage == 0 ? 16 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == 0
                      ? Colors.white
                      : Colors.white38,
                  borderRadius:
                  BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              AnimatedContainer(
                duration:
                const Duration(milliseconds: 200),
                width: _currentPage == 1 ? 16 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == 1
                      ? Colors.white
                      : Colors.white38,
                  borderRadius:
                  BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        if (_currentPage == 0) ...[
          CheckboxListTile(
            dense: true,
            title: const Text(
              'Show values',
            ),
            value: showValues,
            onChanged: (value) {
              ref.read(showPressureValuesProvider.notifier)
                  .state = value ?? true;
            },
          ),
          const SizedBox(height: 8),],
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: FilledButton.icon(
              onPressed: calibrationRunning
                  ? null
                  : () async {
                try {
                  await CalibrationService(ref)
                      .startCalibration();
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
              icon: const Icon(Icons.refresh),
              label: const Text('Recalibrate'),
            ),
          ),

          if (calibrationRunning)
            Padding(
              padding: const EdgeInsets.only(
                top: 4,
                bottom: 8,
              ),
              child: Column(
                children: [
                  Text(
                    'Collecting baseline ($countdown s)',
                  ),
                  Text(
                    'Frames collected: $frameCount',
                  ),
                ],
              ),
            ),

          const SizedBox(height: 8),

          Expanded(
            child: PageView(
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 2),

                    // const Text(
                    //   'HEAD',
                    //   style: TextStyle(
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),

                    const SizedBox(height: 8),

                        Column(
                          children: [

                            const Text('HEAD'),

                            buildBankGrid(
                              1,
                              sensorValues,
                              baseline,
                              showValues,
                            ),

                            const SizedBox(height: 20),

                            const Text('TORSO'),

                            buildBankGrid(
                              71,
                              sensorValues,
                              baseline,
                              showValues,
                            ),

                            const SizedBox(height: 20),

                            const Text('LEGS'),

                            buildBankGrid(
                              141,
                              sensorValues,
                              baseline,
                              showValues,
                            ),
                          ],
                        ),

                    const SizedBox(height: 12),

                      const SizedBox(height: 8),
                  ],
                ),
              ),

                Column(
                  children: [
                    const _SensorLegend(),

                    Expanded(
                      child: SafeArea(
                        bottom: true,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            16,
                            12,
                            12,
                            24,
                          ),
                          child: _LivePressureChart(
                            frameHistory: frameHistory,
                            visibleSensors: visible,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class _SensorLegend extends ConsumerWidget {
  const _SensorLegend();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visible = ref.watch(visibleSensorsProvider);
    final expanded = ref.watch(legendExpandedProvider);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Column(
        children: [
          // ✅ Header (always visible)
          ListTile(
            dense: true,
            title: const Text('Sensors'),
            subtitle: Text('${visible.length} active'),
            trailing: Icon(
              expanded ? Icons.expand_less : Icons.expand_more,
            ),
            onTap: () {
              ref.read(legendExpandedProvider.notifier).toggle();
            },
          ),

          // ✅ Expanded sensor list
          if (expanded)
            Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 210,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // ✅ 3 columns = readable
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 8,
                  childAspectRatio: 3.2,
                ),
                itemBuilder: (context, index) {
                  final sensor = index + 1;
                  final isOn = visible.contains(sensor);

                  return CheckboxListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text('S$sensor'),
                    value: isOn,
                    onChanged: (_) {
                      ref
                          .read(visibleSensorsProvider.notifier)
                          .toggle(sensor);
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

// class _LivePressureChart extends StatelessWidget {
class _LivePressureChart extends ConsumerWidget {
 // final List<SensorReading> readings;
  final List<List<double>> frameHistory;
  final Set<int> visibleSensors;

  const _LivePressureChart({
  //  required this.readings,
    required this.frameHistory,
    required this.visibleSensors,
  });


  @override
  //Widget build(BuildContext context) {
  Widget build(BuildContext context, WidgetRef ref) {
    final baseline = ref.watch(baselineFrameProvider);
    //if (readings.isEmpty)
    if (frameHistory.isEmpty){
      return const Center(
        child: Text(
          'Waiting for live data…',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    // final now = DateTime.now().millisecondsSinceEpoch.toDouble();

    // final Map<int, List<SensorReading>> grouped = {};
    // for (final r in readings) {
    //   if (visibleSensors.contains(r.sensorNumber)) {
    //     grouped.putIfAbsent(r.sensorNumber, () => []).add(r);
    //   }
    // }



    //

    final lines = visibleSensors.map((sensorNumber) {
      final sensorIndex = sensorNumber - 1;

      final spots = <FlSpot>[];

      for (
      int frameIndex = 0;
      frameIndex < frameHistory.length;
      frameIndex++
      ) {
        final frame = frameHistory[frameIndex];

        if (sensorIndex >= frame.length) {
          continue;
        }

        spots.add(
          FlSpot(
            frameIndex.toDouble(),
            frame[sensorIndex],
          ),
        );
      }

      return LineChartBarData(
        spots: spots,
        isCurved: false,
        barWidth: 3,
        dotData: const FlDotData(
          show: false,
        ),
      );
    }).toList();

    return LineChart(
      LineChartData(
        // minX: -7,
        // maxX: 1,
        minX: 0,
        maxX: frameHistory.isEmpty
            ? 1
            : frameHistory.length.toDouble(),
        minY: -1,
        maxY: 2,

        gridData: FlGridData(
          show: true,
          horizontalInterval: 0.25,
          verticalInterval: 10,
          getDrawingHorizontalLine: (_) =>
              FlLine(color: Colors.white24, strokeWidth: 1),
          getDrawingVerticalLine: (_) =>
              FlLine(color: Colors.white24, strokeWidth: 1),
        ),

        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.white38),
        ),

        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 56,
              interval: 0.5,
              getTitlesWidget: (value, _) => Text(
                '${(value * 100).toInt()}%',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                ),
              ),
            ),
          ),

          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: 25,
              getTitlesWidget: (value, _) => Text(
                '${value.toInt()}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                ),
              ),
            ),
          ),

          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),

        lineBarsData: lines,
      ),
    );
  }
}

