import 'package:flutter/material.dart';
import 'package:wktechnology/models/average_bmi_data.dart';

import '../../widgets/report_header.dart';

class BMIReportView extends StatelessWidget {
  const BMIReportView({super.key, required this.data});

  final List<BMIData> data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const ReportHeader(
            title: 'IMC médio / Faixa de Idade',
            subtitle: 'IMC médio dos candidatos considerando faixa de idade'
                ' de dez em dez anos',
            icon: Icons.scale,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            padding: EdgeInsets.only(bottom: 80),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final bmiData = data[index];
              return CustomBMICard(
                ageRange: bmiData.ageRange,
                averageBMI: bmiData.averageBMI,
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomBMICard extends StatelessWidget {
  final String ageRange;
  final double averageBMI;

  const CustomBMICard({
    super.key,
    required this.ageRange,
    required this.averageBMI,
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Faixa de idade',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    // Main: CrossAxisAlignment.center,
                    children: [
                      Text(
                        ageRange.split(' - ')[0],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' até  ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        ageRange.split(' - ')[1].replaceAll(':', ''),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'anos',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
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
                color: Colors.purple.withValues(alpha: .10),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.scale,
                    color: Colors.purple,
                    size: 20,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        averageBMI.toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'IMC',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.purple[300],
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
