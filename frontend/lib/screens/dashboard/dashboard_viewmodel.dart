import 'package:flutter/cupertino.dart';
import 'package:result_dart/result_dart.dart';
import 'package:wktechnology/repository/reports_repository.dart';

import '../../models/report.dart';

class DashboardViewModel extends ChangeNotifier {
  DashboardViewModel({required this.reportsRepository});

  final ReportsRepository reportsRepository;

  final List<Report> reports = [
    DonorsReport(),
    BMIReport(),
    ObesityReport(),
    StatesReport(),
    AverageAgeReport(),
  ];

  bool isThisReportSelected(Report report) {
    return report.getType() == selectedReport.getType();
  }

  Report selectedReport = ObesityReport();
  void updateSelectedReport(Report report) {
    selectedReport = report;
    notifyListeners();
    if (selectedReport is ObesityReport) {
      getObesityRateByGender();
    }
  }

  Report? getReportByType(ReportType type) {
    return reports.where((r) => r.getType() == type).firstOrNull;
  }

  bool fetchingData = false;
  String? errorMessage;

  void startNewFetch() {
    errorMessage = null;
    fetchingData = true;
    notifyListeners();
  }

  void errorOnFetch({required String message}) {
    errorMessage = message;
    fetchingData = false;
    notifyListeners();
  }

  void successOnFetch() {
    errorMessage = null;
    fetchingData = false;
    notifyListeners();
  }

  Future<void> getObesityRateByGender() async {
    startNewFetch();
    final result = await reportsRepository.getObesityRateByGender();
    if (result is Error) {
      errorOnFetch(message: 'Falha ao carregar relatório, tente novamente');
    }

    if (result is Success) {
      final Map<String, String> data = result.getOrDefault({});

      final report = getReportByType(ReportType.obesity) as ObesityReport?;
      if (report == null) {
        errorOnFetch(message: 'Relatório não encontrado');
      } else {
        report.data = data;
        successOnFetch();
      }
    }
  }
}
