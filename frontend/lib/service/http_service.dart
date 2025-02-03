import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:result_dart/result_dart.dart';

class HttpService {
  final Dio _dio = Dio(
    BaseOptions(
      // baseUrl: 'http://192.168.18.33:8080',
      baseUrl: 'http://10.0.2.2:8082',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  Future<Result<Response>> uploadJson(
      String fileName, List<int> fileInBytes) async {
    try {
      FormData formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(
          fileInBytes,
          filename: fileName,
        ),
      });

      final response = await _dio.post(
        '/api/upload-json',
        data: formData,
        onSendProgress: (sent, total) {
          debugPrint(
            'Upload Progress: ${(sent / total * 100).toStringAsFixed(2)}%',
          );
        },
      );
      return Success(response);
    } on DioException catch (error, stack) {
      debugPrint('dio exception: $error \nstack: $stack');
      return Failure(error);
    } catch (error, stack) {
      debugPrint('dio exception: $error \nstack: $stack');
      if (error is Exception) {
        return Failure(error);
      } else {
        return Failure(Exception('error desconhecido'));
      }
    }
  }

  Future<Result<Map<String, dynamic>>> getReportDataMap({
    required String endpoint,
  }) async {
    try {
      final response = await _dio.get('/api/$endpoint');
      // final Map<String, dynamic> jsonDecoded = jsonDecode();
      return Success(response.data);
    } on DioException catch (error, stack) {
      debugPrint('dio exception: $error \nstack: $stack');
      return Failure(error);
    } catch (error, stack) {
      debugPrint('dio exception: $error \nstack: $stack');
      if (error is Exception) {
        return Failure(error);
      } else {
        return Failure(Exception('error desconhecido'));
      }
    }
  }

  Future<Result<List<Map<String, dynamic>>>> getReportDataList({
    required String endpoint,
  }) async {
    try {
      final response = await _dio.get('/api/$endpoint');
      List<dynamic> r = response.data;

      return Success(r.map((o) => o as Map<String, dynamic>).toList());
    } on DioException catch (error, stack) {
      debugPrint('dio exception: $error \nstack: $stack');
      return Failure(error);
    } catch (error, stack) {
      debugPrint('dio exception: $error \nstack: $stack');
      if (error is Exception) {
        return Failure(error);
      } else {
        return Failure(Exception('error desconhecido'));
      }
    }
  }
}
