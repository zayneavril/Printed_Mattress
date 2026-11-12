import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/app_scaffold.dart';
import '../widgets/app_title.dart';
import '../state/classification_providers.dart';

class PositionPage extends ConsumerStatefulWidget {
  const PositionPage({super.key});

  @override
  ConsumerState<PositionPage> createState() =>
      _PositionPageState();
}

class _PositionPageState
    extends ConsumerState<PositionPage> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final prediction =
    ref.watch(predictionResultProvider);

    final confidence =
    ref.watch(predictionConfidenceProvider);

    return AppScaffold(
      currentIndex: 3,
      appBar: AppBar(
        title: const AppTitle(
          'Position Classification',
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),

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

          const SizedBox(height: 8),

          Expanded(
            child: PageView(
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Text(
                        prediction ?? 'No Classification',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 105),

                      if (confidence != null)
                        Text(
                          'Confidence: '
                              '${(confidence * 100).toStringAsFixed(1)}%',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                    ],
                  ),
                ),

                Center(
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Time Since Last Position Change',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 25),

                      const Text(
                        '00:00',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}