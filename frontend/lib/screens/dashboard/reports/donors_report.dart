import 'package:flutter/material.dart';
import 'package:wktechnology/models/average_bmi_data.dart';
import 'package:wktechnology/models/donors_data.dart';
import 'package:wktechnology/models/state_data.dart';

class DonorsReportView extends StatelessWidget {
  const DonorsReportView({super.key, required this.data});

  final List<DonorsData> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('BMI'),
        Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final donorData = data[index];
              return Card(
                child: Row(
                  children: [
                    Icon(Icons.analytics, color: Colors.lightBlueAccent[300]),
                    Text(donorData.bloodType),
                    Text(' quantidade: ${donorData.numberOfDonors}'),
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
