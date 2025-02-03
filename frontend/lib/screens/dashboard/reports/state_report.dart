import 'package:flutter/material.dart';
import 'package:wktechnology/models/data/state_data.dart';

import '../../widgets/empty_report_message.dart';
import '../../widgets/report_header.dart';

class StateReportView extends StatelessWidget {
  const StateReportView({
    super.key,
    required this.data,
    required this.empty,
  });

  final List<StateData> data;
  final bool? empty;

  @override
  Widget build(BuildContext context) {
    if (empty ?? true) return EmptyReportMessage();

    return SingleChildScrollView(
      child: Column(
        children: [
          const ReportHeader(
            title: 'Candidatos por Estado',
            subtitle:
                'Número de candidatos e doadores de sangue em cada estado do Brasil',
            icon: Icons.location_city,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            padding: EdgeInsets.only(bottom: 80),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final stateData = data[index];
              return StateCard(
                state: stateData.state,
                stateFullName: stateData.stateFullName,
                numberOfCandidates: stateData.numberOfCandidates,
                numberOfValidDonors: stateData.numberOfValidDonors,
              );
            },
          ),
        ],
      ),
    );
  }
}

class StateCard extends StatelessWidget {
  final String state;
  final String stateFullName;
  final int numberOfCandidates;
  final int numberOfValidDonors;

  const StateCard({
    super.key,
    required this.state,
    required this.stateFullName,
    required this.numberOfCandidates,
    required this.numberOfValidDonors,
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
                color: Colors.green.withValues(alpha: .10),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  state,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
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
                    stateFullName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        numberOfCandidates.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Candidatos',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        numberOfValidDonors.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Possíveis doadores',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
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
