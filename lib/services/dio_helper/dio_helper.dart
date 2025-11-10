import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/const/api_consts.dart';
import '../../features/candidate/data/repository/candidate_repository.dart';
import '../cache/cache_helper.dart';

class DioHelper {
  static Future<Response?> postLoginData(
      {required String url, Map<String, dynamic>? data}) async {
    try {
      final response = await Dio(BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
        followRedirects: false,
        validateStatus: (status) {
          return status! <= 505;
        },
      )).post(url, data: data);

      log('RESPONSE URL:${response.requestOptions.uri}');
      log('RESPONSE STATUS CODE:${response.statusCode}');
      log('RESPONSE DATA:${response.data}');
      log('RESPONSE REQUEST OPTIONS:${response.requestOptions.data}');

      if (response.statusCode == 422 || response.statusCode == 401) {
        await CandidateRepository.generateNewToken();
      }
      return response;
    } catch (e) {
      log('$e');

      return e is DioException ? e.response : null;
    }
  }

  static Future<Response?> deleteData(
      {required String url,
      Map<String, dynamic>? data,
      Map<String, dynamic>? query}) async {
    try {
      final response = await Dio(BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
        followRedirects: false,
        validateStatus: (status) {
          return status! <= 505;
        },
      )).delete(url,
          options: Options(
              headers: {'Authorization': 'Bearer ${CacheHelper.getToken}'}),
          data: data,
          queryParameters: query);

      log('RESPONSE URL:${response.requestOptions.uri}');
      log('RESPONSE STATUS CODE:${response.statusCode}');
      log('RESPONSE DATA:${response.data}');
      log('RESPONSE REQUEST OPTIONS:${response.requestOptions.data}');

      if (response.statusCode == 422 || response.statusCode == 401) {
        await CandidateRepository.generateNewToken();
      }
      return response;
    } catch (e) {
      log('$e');

      return e is DioException ? e.response : null;
    }
  }

  static Future<Response?> putData(
      {required String url, Map<String, dynamic>? data}) async {
    try {
      final response = await Dio(BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
        followRedirects: false,
        validateStatus: (status) => status! <= 505,
        headers: {"Content-Type": "application/json"},
      )).put(url, data: data);

      log('RESPONSE URL:${response.requestOptions.uri}');
      log('RESPONSE STATUS CODE:${response.statusCode}');
      log('RESPONSE DATA:${response.data}');

      log('RESPONSE REQUEST OPTIONS:${response.requestOptions.data}');
      if (response.statusCode == 422 || response.statusCode == 401) {
        await CandidateRepository.generateNewToken();
      } else if (response.statusCode == 401) {}
      return response;
    } catch (e) {
      log('$e');

      return e is DioException ? e.response : null;
    }
  }

  static Future<Response?> postData(
      {required String url, data, query, baseurl}) async {
    try {
      final response = await Dio(BaseOptions(
        baseUrl: baseurl ?? EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
        followRedirects: false,
        validateStatus: (status) {
          return status! <= 505;
        },
      )).post(url,
          options: Options(
              headers: {'Authorization': 'Bearer ${CacheHelper.getToken}'}),
          data: data,
          queryParameters: query);

      log('RESPONSE URL:${response.requestOptions.uri}');
      log('RESPONSE STATUS CODE:${response.statusCode}');
      log('RESPONSE DATA:${response.data}');
      log('RESPONSE REQUEST OPTIONS:${response.requestOptions.data}');
      if (response.statusCode == 422 || response.statusCode == 401) {
        await CandidateRepository.generateNewToken();
      }
      return response;
    } catch (e) {
      log('$e');

      return e is DioException ? e.response : null;
    }
  }

  static Future<Response?> getDataWithoutToken(
      {required String url, Map<String, dynamic>? data}) async {
    try {
      final response = await Dio(BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
        followRedirects: false,
        validateStatus: (status) {
          return status! <= 500;
        },
      )).get(url, data: data);
      log('RESPONSE STATUS CODE:${response.statusCode}');
      log('RESPONSE DATA:${response.data}');
      log('RESPONSE REQUEST OPTIONS:${response.requestOptions.data}');

      return response;
    } catch (e) {
      log('$e');

      return e is DioException ? e.response : null;
    }
  }

  static Future<Response?> updateData(
      {required String url,
      Map<String, dynamic>? data,
      Map<String, dynamic>? query}) async {
    try {
      final response = await Dio(BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
        validateStatus: (status) => true,
      )).put(
        url,
        options: Options(headers: {
          'Authorization': 'Bearer ${CacheHelper.getToken}',
        }),
        data: data,
        queryParameters: query,
      );
      log('FULL URL: ${response.realUri}');
      log('RESPONSE STATUS CODE:${response.statusCode}');
      log('RESPONSE DATA:${response.data}');
      log('RESPONSE REQUEST OPTIONS:${response.requestOptions.data}');

      return response;
    } catch (e) {
      log('$e');

      return e is DioException ? e.response : null;
    }
  }

  static Future<Response?> getData(
      {required String url,
      Map<String, dynamic>? data,
      Map<String, dynamic>? query}) async {
    try {
      final response = await Dio(BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
        validateStatus: (status) => true,
      )).get(
        url,
        options: Options(
            headers: {'Authorization': 'Bearer ${CacheHelper.getToken}'}),
        data: data,
        queryParameters: query,
      );
      log('FULL URL: ${response.realUri}');
      log('RESPONSE STATUS CODE:${response.statusCode}');
      log('RESPONSE DATA:${response.data}');
      log('RESPONSE REQUEST OPTIONS:${response.requestOptions.data}');

      return response;
    } catch (e) {
      log('$e');

      return e is DioException ? e.response : null;
    }
  }
}
