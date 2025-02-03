import 'package:flutter/material.dart';
import 'package:wktechnology/models/data/average_age_data.dart';
import 'package:wktechnology/models/data/average_bmi_data.dart';
import 'package:wktechnology/models/data/donors_data.dart';
import 'package:wktechnology/models/data/obesity_data.dart';
import 'package:wktechnology/models/data/state_data.dart';

typedef FutureVoidCallback = Future<void> Function();

typedef ReportBuilder<T> = Widget Function(T, bool);

class Report<T> {
  Report({
    required this.data,
    required this.name,
    required this.icon,
    required this.builder,
    required this.fetch,
  });

  T data;
  String name;
  IconData icon;
  ReportBuilder<T> builder;
  FutureVoidCallback fetch;

  setData(List<dynamic>? untypedData) {
    if (untypedData == null) {
      return;
    } else {
      data = untypedData as T;
    }
  }

  bool get isEmpty => throw UnimplementedError();
  Widget get view => throw UnimplementedError();
}