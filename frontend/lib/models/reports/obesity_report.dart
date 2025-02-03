import 'package:flutter/material.dart';
import 'package:wktechnology/models/reports/report.dart';

import '../data/obesity_data.dart';

class ObesityReport extends Report<List<ObesityData>> {
  ObesityReport({
    required super.builder,
    required super.fetch,
  }) : super(
          data: [],
          name: 'Obesidade',
          icon: Icons.monitor_weight,
        );

  @override
  bool get isEmpty {
    double allRate = 0.0;
    for (final obesityData in data) {
      allRate += obesityData.obesityRate;
    }
    return allRate == 0.0;
  }

  @override
  Widget get view => builder(data, isEmpty);
}
