import 'dart:io';
import 'dart:typed_data';

import 'package:result_dart/result_dart.dart';
import 'package:wktechnology/models/average_age_data.dart';
import 'package:wktechnology/models/average_bmi_data.dart';
import 'package:wktechnology/models/donors_data.dart';
import 'package:wktechnology/models/state_data.dart';
import 'package:wktechnology/service/http_service.dart';

import '../models/obesity_data.dart';

abstract class ReportsRepository {
  Future<Result<String>> uploadJson(String fileName, File file);

  Future<Result<List<StateData>>> getCandidatesOfEachState();

  Future<Result<List<BMIData>>> getAverageBMIByAgeRange();

  Future<Result<ObesityData>> getObesityRateByGender();

  Future<Result<List<AverageAgeData>>> getAverageAgeByBloodType();

  Future<Result<List<DonorsData>>> getNumberOfDonorsByBloodType();
}

class ReportsRepositoryImpl implements ReportsRepository {
  HttpService httpService = HttpService();

  @override
  Future<Result<List<StateData>>> getCandidatesOfEachState() async {
    final result = await httpService.getReportDataList(
      endpoint: 'candidates-of-each-state',
    );
    return result.fold(
      (json) {
        final data = json.map((obj) => StateData.fromJson(obj)).toList();
        data.sort(
          (s1, s2) => s1.numberOfCandidates.compareTo(s2.numberOfCandidates),
        );
        return Success(data.reversed.toList());
      },
      (failure) => Failure(failure),
    );
  }

  @override
  Future<Result<ObesityData>> getObesityRateByGender() async {
    final result = await httpService.getReportDataMap(
      endpoint: 'obesity-rate-by-gender',
    );
    return result.fold(
      (json) => Success(ObesityData.fromJson(json)),
      (failure) => Failure(failure),
    );
  }

  @override
  Future<Result<List<AverageAgeData>>> getAverageAgeByBloodType() async {
    final result = await httpService.getReportDataList(
      endpoint: 'average-age-by-blood-type',
    );
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
    return result.fold(
      (json) {
        final data = json.map((o) => DonorsData.fromJson(o)).toList();
        data.sort((d1,d2) => d1.numberOfDonors.compareTo(d2.numberOfDonors));
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

class ReportsRepositoryMock implements ReportsRepository {
  final mockDelayDuration = Duration(milliseconds: 1500);

  Future<void> mockDelay() => Future.delayed(mockDelayDuration);

  @override
  Future<Result<ObesityData>> getObesityRateByGender() async {
    await mockDelay();
    return Success(
      ObesityData(
        maleObesityRate: 25,
        femaleObesityRate: 20,
      ),
    );
  }

  @override
  Future<Result<String>> uploadJson(String fileName, File file) async {
    throw UnimplementedError();
  }

  @override
  Future<Result<List<AverageAgeData>>> getAverageAgeByBloodType() {
    // TODO: implement getAverageAgeByBloodType
    throw UnimplementedError();
  }

  @override
  Future<Result<List<BMIData>>> getAverageBMIByAgeRange() {
    // TODO: implement getAverageBMIByAgeRange
    throw UnimplementedError();
  }

  @override
  Future<Result<List<StateData>>> getCandidatesOfEachState() {
    // TODO: implement getCandidatesOfEachState
    throw UnimplementedError();
  }

  @override
  Future<Result<List<DonorsData>>> getNumberOfDonorsByBloodType() {
    // TODO: implement getNumberOfDonorsByBloodType
    throw UnimplementedError();
  }
}
