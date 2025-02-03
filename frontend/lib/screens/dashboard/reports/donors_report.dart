import 'package:flutter/material.dart';
import 'package:wktechnology/models/average_bmi_data.dart';
import 'package:wktechnology/models/donors_data.dart';
import 'package:wktechnology/models/state_data.dart';

import '../../widgets/report_header.dart';

class DonorsReportView extends StatelessWidget {
  const DonorsReportView({super.key, required this.data});

  final List<DonorsData> data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const ReportHeader(
            title: 'Doadores',
            subtitle: 'Possíveis doadores para cada tipo sanguíneo receptor',
            icon: Icons.bloodtype,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            padding: EdgeInsets.only(bottom: 80),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final donorsData = data[index];
              return CustomBloodCard(
                bloodType: donorsData.bloodTypeLabel,
                numberOfDonors: donorsData.numberOfDonors,
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomBloodCard extends StatelessWidget {
  final String bloodType;
  final int numberOfDonors;

  const CustomBloodCard({
    super.key,
    required this.bloodType,
    required this.numberOfDonors,
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
            // Left side - Blood Type Icon/Image
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
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
            // Right side - Donor Count
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Número de doadores',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    numberOfDonors.toString(),
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

// Example usage:
class BloodDonorList extends StatelessWidget {
  const BloodDonorList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        CustomBloodCard(bloodType: 'A+', numberOfDonors: 28),
        CustomBloodCard(bloodType: 'B+', numberOfDonors: 23),
        CustomBloodCard(bloodType: 'O+', numberOfDonors: 40),
        // Add more blood types as needed
      ],
    );
  }
}
