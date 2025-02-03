import 'package:flutter/material.dart';

import '../data/average_bmi_data.dart';
import 'report.dart';

class BMIReport extends Report<List<BMIData>> {
  BMIReport({
    required super.builder,
    required super.fetch,
  }) : super(
          data: [],
          name: 'IMC',
          icon: Icons.scale,
        );

  @override
  bool get isEmpty => data.isEmpty;

  @override
  Widget get view => builder(data, isEmpty);
}
