import 'package:flutter/material.dart';
import 'package:wktechnology/models/reports/report.dart';

import '../data/state_data.dart';

class StatesReport extends Report<List<StateData>> {
  StatesReport({
    required super.builder,
    required super.fetch,
  }) : super(
          data: [],
          name: 'Estados',
          icon: Icons.location_city,
        );

  @override
  bool get isEmpty => data.isEmpty;

  @override
  Widget get view => builder(data, isEmpty);
}
