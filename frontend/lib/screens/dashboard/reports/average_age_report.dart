import 'package:flutter/material.dart';
import 'package:wktechnology/models/average_age_data.dart';
import 'package:wktechnology/models/average_bmi_data.dart';
import 'package:wktechnology/models/donors_data.dart';
import 'package:wktechnology/models/state_data.dart';

class AverageAgeReportView extends StatelessWidget {
  const AverageAgeReportView({super.key, required this.data});

  final List<AverageAgeData> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('BMI'),
        Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final averageAgeData = data[index];
              return Card(
                child: Row(
                  children: [
                    Icon(Icons.analytics, color: Colors.lightBlueAccent[300]),
                    Text(averageAgeData.bloodType),
                    Text(' média de idade: ${averageAgeData.averageAge}'),
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
