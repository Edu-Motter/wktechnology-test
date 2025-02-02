import 'package:flutter/material.dart';
import 'package:wktechnology/models/average_bmi_data.dart';
import 'package:wktechnology/models/state_data.dart';

class BMIReportView extends StatelessWidget {
  const BMIReportView({super.key, required this.data});

  final List<BMIData> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('BMI'),
        Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final bmi = data[index];
              return Card(
                child: Row(
                  children: [
                    Icon(Icons.analytics, color: Colors.lightBlueAccent[300]),
                    Text(bmi.ageRange),
                    Text('média: ${bmi.averageBMI}'),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
