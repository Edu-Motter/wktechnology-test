import 'package:flutter/material.dart';
import 'package:wktechnology/models/reports/report.dart';

import '../data/average_age_data.dart';

class AverageAgeReport extends Report<List<AverageAgeData>> {
  AverageAgeReport({
    required super.builder,
    required super.fetch,
  }) : super(
          data: [],
          name: 'Idade',
          icon: Icons.people,
        );

  @override
  bool get isEmpty => data.isEmpty;

  @override
  Widget get view => builder(data, isEmpty);
}
