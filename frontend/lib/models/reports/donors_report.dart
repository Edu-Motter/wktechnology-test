import 'package:flutter/material.dart';
import 'package:wktechnology/models/reports/report.dart';

import '../data/donors_data.dart';

class DonorsReport extends Report<List<DonorsData>> {
  DonorsReport({
    required super.builder,
    required super.fetch,
  }) : super(
          data: [],
          name: 'Doadores',
          icon: Icons.bloodtype,
        );

  @override
  bool get isEmpty {
    int allDonors = 0;
    for (final donorsData in data) {
      allDonors += donorsData.numberOfDonors;
    }
    return allDonors == 0;
  }

  @override
  Widget get view => builder(data, isEmpty);
}
