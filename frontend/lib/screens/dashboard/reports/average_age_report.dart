import 'package:flutter/material.dart';
import 'package:wktechnology/models/average_age_data.dart';

import '../../widgets/report_header.dart';

class AverageAgeReportView extends StatelessWidget {
  const AverageAgeReportView({super.key, required this.data});

  final List<AverageAgeData> data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const ReportHeader(
            title: 'Média de idade por tipo sanguíneo',
            // subtitle: 'Média de idade para cada tipo sanguíneo',
            icon: Icons.people_alt_rounded,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            padding: EdgeInsets.only(bottom: 80),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final ageData = data[index];
              return CustomAgeCard(
                bloodType: ageData.bloodTypeLabel,
                averageAge: ageData.averageAge,
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomAgeCard extends StatelessWidget {
  final String bloodType;
  final double averageAge;

  const CustomAgeCard({
    super.key,
    required this.bloodType,
    required this.averageAge,
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
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: .10),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  bloodType,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Média de idade',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    averageAge.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
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
