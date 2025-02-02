import 'package:flutter/material.dart';

enum ReportType {
  donors(label: 'Doadores', icon: Icons.bloodtype),
  bmi(label: 'IMC', icon: Icons.scale),
  obesity(label: 'Obesidade', icon: Icons.monitor_weight),
  states(label: 'Estados', icon: Icons.pin_drop),
  averageAge(label: 'Idade', icon: Icons.cake);

  final IconData icon;
  final String label;

  const ReportType({required this.icon, required this.label});
}

abstract class Report<T> {
  T getData();
  ReportType getType();
}

class DonorsReport implements Report<Map<String, dynamic>> {
  Map<String, dynamic>? data;

  @override
  Map<String, dynamic> getData() => data ?? {};

  @override
  ReportType getType() => ReportType.donors;
}

class BMIReport implements Report<Map<String, String>> {
  Map<String, String>? data;

  @override
  Map<String, String> getData() => data ?? {};

  @override
  ReportType getType() => ReportType.bmi;
}

class ObesityReport implements Report<Map<String, String>> {
  Map<String, String>? data;

  @override
  Map<String, String> getData() => data ?? {};

  @override
  ReportType getType() => ReportType.obesity;
}

class AverageAgeReport implements Report<Map<String, dynamic>> {
  Map<String, dynamic>? data;

  @override
  Map<String, dynamic> getData() => data ?? {};

  @override
  ReportType getType() => ReportType.averageAge;
}

class StatesReport implements Report<Map<String, dynamic>> {
  Map<String, dynamic>? data;

  @override
  Map<String, dynamic> getData() => data ?? {};

  @override
  ReportType getType() => ReportType.states;
}
