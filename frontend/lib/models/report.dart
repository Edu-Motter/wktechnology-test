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
  states(label: 'Estados', icon: Icons.location_city),
  averageAge(label: 'Idade', icon: Icons.people_alt_rounded);

  final IconData icon;
  final String label;

  const ReportType({required this.icon, required this.label});
}

abstract class Report<T> {
  T getData();
  void setData(T data);
  ReportType getType();
}

class DonorsReport implements Report<List<DonorsData>> {
  List<DonorsData>? data;

  @override
  List<DonorsData> getData() => data ?? [];

  @override
  ReportType getType() => ReportType.donors;

  @override
  void setData(List<DonorsData> newData) {
    data = newData;
  }
}

class BMIReport implements Report<List<BMIData>> {
  List<BMIData>? data;

  @override
  List<BMIData> getData() => data ?? [];

  @override
  ReportType getType() => ReportType.bmi;

  @override
  void setData(List<BMIData> newData) {
    data = newData;
  }
}

class ObesityReport implements Report<ObesityData> {
  ObesityData? data;

  @override
  ObesityData getData() => data ?? ObesityData.empty();

  @override
  ReportType getType() => ReportType.obesity;

  @override
  void setData(ObesityData newData) {
    data = newData;
  }
}

class AverageAgeReport implements Report<List<AverageAgeData>> {
  List<AverageAgeData>? data;

  @override
  List<AverageAgeData> getData() => data ?? [];

  @override
  ReportType getType() => ReportType.averageAge;

  @override
  void setData(List<AverageAgeData> newData) {
    data = newData;
  }
}

class StatesReport implements Report<List<StateData>> {
  List<StateData>? data;

  @override
  List<StateData> getData() => data ?? [];

  @override
  ReportType getType() => ReportType.states;

  @override
  void setData(List<StateData> newData) {
    data = newData;
  }
}
