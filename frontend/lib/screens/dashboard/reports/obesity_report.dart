import 'package:flutter/material.dart';
import 'package:wktechnology/models/obesity_data.dart';

import '../../widgets/report_header.dart';

class ObesityReportView extends StatelessWidget {
  const ObesityReportView({super.key, required this.data});

  final List<ObesityData> data;

  String getLabel(String gender) {
    switch (gender) {
      case 'women':
        return 'Entre as mulheres';
      case 'men':
        return 'Entre os homens';
      default:
        return 'Não informado';
    }
  }

  MaterialColor getColor(String gender) {
    switch (gender) {
      case 'women':
        return Colors.pink;
      case 'men':
        return Colors.blue;
      default:
        return Colors.orange;
    }
  }

  IconData getIcon(String gender) {
    switch (gender) {
      case 'women':
        return Icons.female;
      case 'men':
        return Icons.male;
      default:
        return Icons.monitor_weight;
    }
  }

  @override
  Widget build(BuildContext context) {
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
            itemCount: data.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final obesityData = data[index];
              return CustomObesityCard(
                icon: getIcon(obesityData.gender),
                color: getColor(obesityData.gender),
                gender: getLabel(obesityData.gender),
                obesityRate: obesityData.obesityRate,
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
  final IconData icon;

  const CustomObesityCard({
    super.key,
    required this.gender,
    required this.obesityRate,
    required this.color,
    required this.icon,
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
              width: 136,
              height: 72,
              decoration: BoxDecoration(
                color: color.withValues(alpha: .10),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: color,
                    size: 32,
                  ),
                  const SizedBox(width: 8),
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
