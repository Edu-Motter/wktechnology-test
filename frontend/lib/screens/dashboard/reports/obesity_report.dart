import 'package:flutter/material.dart';
import 'package:wktechnology/models/obesity_data.dart';

import '../../widgets/report_header.dart';

class ObesityReportView extends StatelessWidget {
  const ObesityReportView({super.key, required this.data});

  final ObesityData data;

  @override
  Widget build(BuildContext context) {
    List<double> genders = [data.femaleObesityRate, data.maleObesityRate];

    return SingleChildScrollView(
      child: Column(
        children: [
          const ReportHeader(
            title: 'Percentual de obesos',
            subtitle:
                'Percentual de candidatos obesos entre os homens e entre as mulheres',
            icon: Icons.monitor_weight,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: genders.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final obesityRate = genders[index];
              return CustomObesityCard(
                gender: index == 0 ? 'Entre as mulheres' : 'Entre os homens',
                color: index == 0 ? Colors.pink : Colors.lightBlue,
                obesityRate: obesityRate,
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomObesityCard extends StatelessWidget {
  final String gender;
  final double obesityRate;
  final MaterialColor color;

  const CustomObesityCard({
    super.key,
    required this.gender,
    required this.obesityRate,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        gender.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 120,
              height: 72,
              decoration: BoxDecoration(
                color: color.withValues(alpha: .10),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.monitor_weight,
                    color: color,
                    size: 24,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '${(obesityRate * 100).toStringAsFixed(2)}%',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}