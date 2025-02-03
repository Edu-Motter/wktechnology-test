import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:result_dart/result_dart.dart';
import 'package:wktechnology/repository/reports_repository.dart';
import 'package:wktechnology/screens/dashboard/reports/average_age_report.dart';
import 'package:wktechnology/screens/dashboard/reports/bmi_report.dart';
import 'package:wktechnology/screens/dashboard/reports/donors_report.dart';
import 'package:wktechnology/screens/dashboard/reports/obesity_report.dart';
import 'package:wktechnology/screens/dashboard/reports/state_report.dart';

import '../../models/reports/average_age_report.dart';
import '../../models/reports/bmi_report.dart';
import '../../models/reports/donors_report.dart';
import '../../models/reports/obesity_report.dart';
import '../../models/reports/report.dart';
import '../../models/reports/states_report.dart';

class DashboardViewModel extends ChangeNotifier {
  DashboardViewModel({required this.reportsRepository});

  final ReportsRepository reportsRepository;

  Report? selectedReport;
  bool fetchingData = false;
  String? errorMessage;

  final List<Report> reports = [
    DonorsReport(
      builder: (data, empty) => DonorsReportView(data: data, empty: empty),
      fetch: () async {},
    ),
    BMIReport(
      builder: (data, empty) => BMIReportView(data: data, empty: empty),
      fetch: () async {},
    ),
    ObesityReport(
        builder: (data, empty) => ObesityReportView(data: data, empty: empty),
        fetch: () async {}),
    StatesReport(
      builder: (data, empty) => StateReportView(data: data, empty: empty),
      fetch: () async {},
    ),
    AverageAgeReport(
      builder: (data, empty) => AverageAgeReportView(data: data, empty: empty),
      fetch: () async {},
    ),
  ];

  Future<void> fetchReportData() async {
    startNewFetch();
    try {
      Result? result;
      if (selectedReport is StatesReport) {
        result = await reportsRepository.getCandidatesOfEachState();
      }

      if (selectedReport is BMIReport) {
        result = await reportsRepository.getAverageBMIByAgeRange();
      }
      if (selectedReport is ObesityReport) {
        result = await reportsRepository.getObesityRateByGender();
      }

      if (selectedReport is AverageAgeReport) {
        result = await reportsRepository.getAverageAgeByBloodType();
      }
      if (selectedReport is DonorsReport) {
        result = await reportsRepository.getNumberOfDonorsByBloodType();
      }

      if (result is Success) {
        selectedReport?.setData((result?.getOrNull()) as List<dynamic>?);
        successOnFetch();
      } else {
        errorOnFetch(
          message: 'Falha ao carregar relatório, tente novamente',
        );
      }
    } catch (error, stack) {
      debugPrint(
        'error in ${selectedReport.runtimeType} fetch: $error \nstack: $stack',
      );
      errorOnFetch(
        message: 'Ocorreu um erro desconhecido',
      );
    }
  }

  Future<Result<String>> getJsonAndUpload() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result == null) {
        return Failure(Exception('Nenhum JSON foi selecionado'));
      }

      if (result.files.single.path == null) {
        return Failure(Exception('Caminho inválido do JSON'));
      }

      File json = File(result.files.single.path!);
      String fileName = result.files.single.name;
      final uploadResult = await reportsRepository.uploadJson(fileName, json);
      executeRefresh();
      return uploadResult;
    } catch (e) {
      return Failure(Exception(e));
    }
  }

  bool isThisReportSelected(index) {
    return reports[index].runtimeType == selectedReport?.runtimeType;
  }

  void executeRefresh() {
    selectedReport ??= reports.first;
    updateSelectedReport(selectedReport!);
  }

  void updateSelectedReport(Report report) {
    selectedReport = report;
    fetchReportData();
  }

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
}
