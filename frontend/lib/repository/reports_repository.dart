import 'package:result_dart/result_dart.dart';

abstract class ReportsRepository {
  Future<Result<Map<String, String>>> getObesityRateByGender();
}

class ReportsRepositoryImpl implements ReportsRepository {
  @override
  Future<Result<Map<String, String>>> getObesityRateByGender() async {
    await Future.delayed(Duration(seconds: 1));
    return Success({
      'maleObesityRate': '25.00%',
      'femaleObesityRate': '15.50%',
    });
    throw UnimplementedError();
  }
}

class ReportsRepositoryMock implements ReportsRepository {
  final mockDelayDuration = Duration(milliseconds: 1500);

  Future<void> mockDelay() => Future.delayed(mockDelayDuration);

  @override
  Future<Result<Map<String, String>>> getObesityRateByGender() async {
    await mockDelay();
    return Success({
      'maleObesityRate': '25.00%',
      'femaleObesityRate': '15.50%',
    });
  }
}

