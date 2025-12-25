import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../core/const/api_consts.dart';
import '../../features/candidate/data/repository/candidate_repository.dart';
import '../cache/cache_helper.dart';

class DioHelper {
  DioHelper._();

  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
        validateStatus: (_) => true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = CacheHelper.token;
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          options.headers['Accept'] = 'application/json';
          options.headers['Content-Type'] ??= 'application/json';

          log('➡️ REQUEST');
          log('URL: ${options.uri}');
          log('METHOD: ${options.method}');
          log('HEADERS: ${options.headers}');
          log('DATA: ${options.data}');
          log('QUERY: ${options.queryParameters}');

          handler.next(options);
        },

        // =====================
        // Response
        // =====================
        onResponse: (response, handler) async {
          log('✅ RESPONSE');
          log('URL: ${response.requestOptions.uri}');
          log('STATUS CODE: ${response.statusCode}');
          log('DATA: ${response.data}');
          handler.next(response);

          if (CacheHelper.token != null &&
                  JwtDecoder.isExpired(CacheHelper.token!) ||
              response.statusCode == 401 ||
              response.statusCode == 422) {
            await CandidateRepository.login(
                CacheHelper.email!, CacheHelper.password!);
          }
        },

        onError: (DioException e, handler) async {
          log('❌ ERROR');
          log('URL: ${e.requestOptions.uri}');
          log('STATUS: ${e.response?.statusCode}');
          log('ERROR: ${e.message}');
          log('DATA: ${e.response?.data}');

          await CandidateRepository.login(
              CacheHelper.email!, CacheHelper.password!);

          // final newToken = CacheHelper.token;
          // if (newToken != null) {
          //   final requestOptions = e.requestOptions;
          //   requestOptions.headers['Authorization'] = 'Bearer $newToken';
          //
          //   final response = await dio.fetch(requestOptions);
          //   return handler.resolve(response);
          // }

          handler.next(e);
        },
      ),
    );
  }

  static Future<Response?> getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await dio.get(
        url,
        queryParameters: query,
        data: data,
        options: Options(headers: headers),
      );
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<Response?> getDataWithoutToken({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await dio.get(
        url,
        queryParameters: query,
        options: Options(headers: headers),
      );
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<Response?> postData({
    required String url,
    dynamic data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await dio.post(
        url,
        data: data,
        queryParameters: query,
        options: Options(headers: headers),
      );
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<Response?> postLoginData({
    required String url,
    dynamic data,
  }) async {
    try {
      final response = await Dio(
        BaseOptions(
          baseUrl: EndPoints.baseUrl,
          receiveDataWhenStatusError: true,
          validateStatus: (_) => true,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      ).post(
        url,
        data: data,
      );

      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<Response?> putData({
    required String url,
    dynamic data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await dio.put(
        url,
        data: data,
        queryParameters: query,
        options: Options(headers: headers),
      );
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<Response?> deleteData({
    required String url,
    dynamic data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await dio.delete(
        url,
        data: data,
        queryParameters: query,
        options: Options(headers: headers),
      );
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<Response?> postFormData({
    required String url,
    required FormData data,
    Map<String, dynamic>? query,
  }) async {
    try {
      return await dio.post(
        url,
        data: data,
        queryParameters: query,
        options: Options(contentType: 'multipart/form-data'),
      );
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
