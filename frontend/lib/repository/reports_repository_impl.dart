import 'dart:io';

import 'package:result_dart/result_dart.dart';

import '../models/data/average_age_data.dart';
import '../models/data/average_bmi_data.dart';
import '../models/data/donors_data.dart';
import '../models/data/obesity_data.dart';
import '../models/data/state_data.dart';
import '../service/http_service.dart';
import 'reports_repository.dart';

class ReportsRepositoryImpl implements ReportsRepository {
  HttpService httpService = HttpService();

  final animationDuration = Duration(milliseconds: 300);

  Future<void> animationDelay() => Future.delayed(animationDuration);

  @override
  Future<Result<List<StateData>>> getCandidatesOfEachState() async {
    final result = await httpService.getReportDataList(
      endpoint: 'candidates-of-each-state',
    );
    await animationDelay();
    return result.fold(
      (json) {
        final data = json.map((o) => StateData.fromJson(o)).toList();
        data.sort(
          (s1, s2) => s1.numberOfCandidates.compareTo(s2.numberOfCandidates),
        );
        return Success(data.reversed.toList());
      },
      (failure) => Failure(failure),
    );
  }

  @override
  Future<Result<List<ObesityData>>> getObesityRateByGender() async {
    final result = await httpService.getReportDataList(
      endpoint: 'obesity-rate-by-gender',
    );
    await animationDelay();
    return result.fold(
      (json) => Success(json.map((o) => ObesityData.fromJson(o)).toList()),
      (failure) => Failure(failure),
    );
  }

  @override
  Future<Result<List<AverageAgeData>>> getAverageAgeByBloodType() async {
    final result = await httpService.getReportDataList(
      endpoint: 'average-age-by-blood-type',
    );
    await animationDelay();
    return result.fold(
      (json) {
        final data = json.map((o) => AverageAgeData.fromJson(o)).toList();
        data.sort((s1, s2) => s1.averageAge.compareTo(s2.averageAge));
        return Success(data);
      },
      (failure) => Failure(failure),
    );
  }

  @override
  Future<Result<List<BMIData>>> getAverageBMIByAgeRange() async {
    final result = await httpService.getReportDataList(
      endpoint: 'average-bmi-by-age-range',
    );
    await animationDelay();
    return result.fold(
      (json) {
        final data = json.map((o) => BMIData.fromJson(o)).toList();
        data.sort((b1, b2) => b1.ageRange.compareTo(b2.ageRange));
        return Success(data);
      },
      (failure) => Failure(failure),
    );
  }

  @override
  Future<Result<List<DonorsData>>> getNumberOfDonorsByBloodType() async {
    final result = await httpService.getReportDataList(
      endpoint: 'number-of-donors-by-blood-type',
    );
    await animationDelay();
    return result.fold(
      (json) {
        final data = json.map((o) => DonorsData.fromJson(o)).toList();
        data.sort((d1, d2) => d1.numberOfDonors.compareTo(d2.numberOfDonors));
        return Success(data.reversed.toList());
      },
      (failure) => Failure(failure),
    );
  }

  @override
  Future<Result<String>> uploadJson(String fileName, File file) async {
    if (!fileName.contains('.json')) {
      return Failure(
        Exception('Somente arquivos JSON podem ser enviados'),
      );
    }

    final bytes = file.readAsBytesSync();
    final result = await httpService.uploadJson(fileName, bytes);
    return result.fold(
      (success) => Success(
        'Arquivo $fileName enviado com sucesso',
      ),
      (error) => Failure(error),
    );
  }
}
