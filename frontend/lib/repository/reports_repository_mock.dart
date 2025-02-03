import 'dart:io';

import 'package:result_dart/result_dart.dart';

import '../models/data/average_age_data.dart';
import '../models/data/average_bmi_data.dart';
import '../models/data/donors_data.dart';
import '../models/data/obesity_data.dart';
import '../models/data/state_data.dart';
import 'reports_repository.dart';

class ReportsRepositoryMock implements ReportsRepository {
  final mockDelayDuration = Duration(milliseconds: 1500);

  Future<void> mockDelay() => Future.delayed(mockDelayDuration);

  @override
  Future<Result<List<ObesityData>>> getObesityRateByGender() async {
    await mockDelay();
    return Success([
      ObesityData(
        gender: 'women',
        obesityRate: 15,
      ),
      ObesityData(
        gender: 'men',
        obesityRate: 25,
      ),
    ]);
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
