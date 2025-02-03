import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:result_dart/result_dart.dart';
import 'package:wktechnology/models/average_age_data.dart';
import 'package:wktechnology/models/average_bmi_data.dart';
import 'package:wktechnology/models/donors_data.dart';
import 'package:wktechnology/models/obesity_data.dart';
import 'package:wktechnology/models/state_data.dart';
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
    return report.getType() == selectedReport?.getType();
  }

  Report? selectedReport;
  void updateSelectedReport(Report report) {
    selectedReport = report;
    notifyListeners();
    if (selectedReport is ObesityReport) {
      getObesityRateByGender();
    }
    if (selectedReport is StatesReport) {
      getCandidatesOfEachState();
    }
    if (selectedReport is BMIReport) {
      getAverageBMIByAgeRange();
    }
    if (selectedReport is AverageAgeReport) {
      getAverageAgesByBloodType();
    }
    if (selectedReport is DonorsReport) {
      getNumberOfDonorsByBloodType(selectedReport as DonorsReport);
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

  //getReportData ( reportData, reportType and method repo.get<>() )
  //Create a generic get to handle results
  Future<void> getNumberOfDonorsByBloodType(DonorsReport report) async {
    startNewFetch();
    try {
      final result = await reportsRepository.getNumberOfDonorsByBloodType();
      if (result is Error) {
        errorOnFetch(message: 'Falha ao carregar relatório, tente novamente');
      }

      if (result is Success) {
        final List<DonorsData> reportData = result.getOrDefault([]);
        report.setData(reportData);
        successOnFetch();
      }
    } catch (error, stack) {
      debugPrint('error in getObesityRateByGender: $error \nstack: $stack');
      errorOnFetch(message: 'Ocorreu um erro interno');
    }
  }

  Future<void> getAverageAgesByBloodType() async {
    startNewFetch();
    try {
      final result = await reportsRepository.getAverageAgeByBloodType();
      if (result is Error) {
        errorOnFetch(message: 'Falha ao carregar relatório, tente novamente');
      }

      if (result is Success) {
        final List<AverageAgeData> reportData = result.getOrDefault([]);

        final report =
            getReportByType(ReportType.averageAge) as AverageAgeReport?;
        if (report == null) {
          errorOnFetch(message: 'Relatório não encontrado');
        } else {
          report.data = reportData;
          successOnFetch();
        }
      }
    } catch (error, stack) {
      debugPrint('error in getObesityRateByGender: $error \nstack: $stack');
      errorOnFetch(message: 'Ocorreu um erro interno');
    }
  }

  Future<void> getAverageBMIByAgeRange() async {
    startNewFetch();
    try {
      final result = await reportsRepository.getAverageBMIByAgeRange();
      if (result is Error) {
        errorOnFetch(message: 'Falha ao carregar relatório, tente novamente');
      }

      if (result is Success) {
        final List<BMIData> reportData = result.getOrDefault([]);

        final report = getReportByType(ReportType.bmi) as BMIReport?;
        if (report == null) {
          errorOnFetch(message: 'Relatório não encontrado');
        } else {
          report.data = reportData;
          successOnFetch();
        }
      }
    } catch (error, stack) {
      debugPrint('error in getObesityRateByGender: $error \nstack: $stack');
      errorOnFetch(message: 'Ocorreu um erro interno');
    }
  }

  Future<void> getCandidatesOfEachState() async {
    startNewFetch();
    try {
      final result = await reportsRepository.getCandidatesOfEachState();
      if (result is Error) {
        errorOnFetch(message: 'Falha ao carregar relatório, tente novamente');
      }

      if (result is Success) {
        final List<StateData> reportData = result.getOrDefault([]);

        final report = getReportByType(ReportType.states) as StatesReport?;
        if (report == null) {
          errorOnFetch(message: 'Relatório não encontrado');
        } else {
          report.data = reportData;
          successOnFetch();
        }
      }
    } catch (error, stack) {
      debugPrint('error in getObesityRateByGender: $error \nstack: $stack');
      errorOnFetch(message: 'Ocorreu um erro interno');
    }
  }

  Future<void> getObesityRateByGender() async {
    startNewFetch();
    try {
      final result = await reportsRepository.getObesityRateByGender();
      if (result is Error) {
        errorOnFetch(message: 'Falha ao carregar relatório, tente novamente');
      }

      if (result is Success) {
        final List<ObesityData> reportData = result.getOrDefault([]);

        final report = getReportByType(ReportType.obesity) as ObesityReport?;
        if (report == null) {
          errorOnFetch(message: 'Relatório não encontrado');
        } else {
          report.data = reportData;
          successOnFetch();
        }
      }
    } catch (error, stack) {
      debugPrint('error in getObesityRateByGender: $error \nstack: $stack');
      errorOnFetch(message: 'Ocorreu um erro interno');
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
      return await reportsRepository.uploadJson(fileName, json);
    } catch (e) {
      return Failure(Exception(e));
    }
  }
}
