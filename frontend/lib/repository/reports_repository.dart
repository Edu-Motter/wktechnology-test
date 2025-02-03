import 'dart:io';

import 'package:result_dart/result_dart.dart';
import 'package:wktechnology/models/data/average_age_data.dart';
import 'package:wktechnology/models/data/average_bmi_data.dart';
import 'package:wktechnology/models/data/state_data.dart';

import '../models/data/donors_data.dart';
import '../models/data/obesity_data.dart';

abstract class ReportsRepository {
  Future<Result<String>> uploadJson(String fileName, File file);

  Future<Result<List<StateData>>> getCandidatesOfEachState();

  Future<Result<List<BMIData>>> getAverageBMIByAgeRange();

  Future<Result<List<ObesityData>>> getObesityRateByGender();

  Future<Result<List<AverageAgeData>>> getAverageAgeByBloodType();

  Future<Result<List<DonorsData>>> getNumberOfDonorsByBloodType();
}

