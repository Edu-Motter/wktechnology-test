import 'package:flutter/material.dart';

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