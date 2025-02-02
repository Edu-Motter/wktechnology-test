import 'package:flutter/material.dart';
import 'package:wktechnology/models/obesity_data.dart';

class ObesityReportView extends StatelessWidget {
  const ObesityReportView({super.key, required this.data});

  final ObesityData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Percentual de obesos entre os homens e entre as mulheres'),
        Card(
          child: Row(
            children: [
              Icon(Icons.male, color: Colors.lightBlueAccent[300]),
              Text('Homens: ${data.maleObesityRate}')
            ],
          ),
        ),
        SizedBox(height: 16),
        Card(
          child: Row(
            children: [
              Icon(Icons.female, color: Colors.pinkAccent[300]),
              Text('Mulheres: ${data.femaleObesityRate}')
            ],
          ),
        ),
      ],
    );
  }
}
