import 'package:flutter/material.dart';
import 'package:wktechnology/models/average_age_data.dart';
import 'package:wktechnology/models/average_bmi_data.dart';
import 'package:wktechnology/models/donors_data.dart';
import 'package:wktechnology/models/obesity_data.dart';
import 'package:wktechnology/models/state_data.dart';

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

class DonorsReport implements Report<List<DonorsData>> {
  List<DonorsData>? data;

  @override
  List<DonorsData> getData() => data ?? [];

  @override
  ReportType getType() => ReportType.donors;
}

class BMIReport implements Report<List<BMIData>> {
  List<BMIData>? data;

  @override
  List<BMIData> getData() => data ?? [];

  @override
  ReportType getType() => ReportType.bmi;
}

class ObesityReport implements Report<ObesityData> {
  ObesityData? data;

  @override
  ObesityData getData() => data ?? ObesityData.empty();

  @override
  ReportType getType() => ReportType.obesity;
}

class AverageAgeReport implements Report<List<AverageAgeData>> {
  List<AverageAgeData>? data;

  @override
  List<AverageAgeData> getData() => data ?? [];

  @override
  ReportType getType() => ReportType.averageAge;
}

class StatesReport implements Report<List<StateData>> {
  List<StateData>? data;

  @override
  List<StateData> getData() => data ?? [];

  @override
  ReportType getType() => ReportType.states;
}
