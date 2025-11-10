import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fullcycle/features/candidate/data/models/experiences_model.dart';
import 'package:fullcycle/features/candidate/data/models/lookup_model.dart';
import 'package:fullcycle/services/cache/cache_helper.dart';
import 'package:fullcycle/services/navigation/navigation.dart';
import 'package:fullcycle/shared/widgets/custom_snack_bar.dart';

import '../../../../core/const/api_consts.dart';
import '../../../../services/dio_helper/dio_helper.dart';
import '../../../../services/dio_helper/error_handler.dart';
import '../../../../shared/model/user_model.dart';
import '../models/candidate_model.dart';

class CandidateRepository {
  static LookupModel? lookupModel;
  static Future<LookupModel?> getLookUps() async {
    final response = await DioHelper.getData(url: EndPoints.getLookUps);
    if (response?.statusCode == 200) {
      lookupModel = LookupModel.fromJson(response?.data);
    } else {
      errorHandler(response);
    }
    return null;
  }

  static Future<Response?> uploadDocument({
    required String filePath,
    required String documentType,
  }) async {
    try {
      final file = File(filePath);

      final formData = FormData.fromMap({
        "documentType":
            documentType, // e.g., "cv", "criminalRecord", "delegation"
        "file": await MultipartFile.fromFile(file.path,
            filename: file.uri.pathSegments.last),
      });

      final response = await DioHelper.postData(
        url: "/candidate/upload-document",
        data: formData,
      );

      return response;
    } catch (e) {
      return null;
    }
  }

  static Future<Response?> getCandidateExperiences() async {
    final response =
        await DioHelper.getData(url: EndPoints.candidateGetExperience);
    if (response?.statusCode == 200) {
      return response;
    } else {
      // errorHandler(response);
    }
    return null;
  }

  static Future<Response?> getCandidateImage() async {
    final response =
        await DioHelper.postData(url: EndPoints.candidateGetImage, data: {
      'docType': 1,
    });
    if (response?.statusCode == 200) {
      return response;
    } else {
      errorHandler(response);
    }
    return null;
  }

  static Future<Response?> getCandidateBanks() async {
    final response = await DioHelper.getData(url: EndPoints.candidateGetBanks);
    if (response?.statusCode == 200) {
      return response;
    } else {
      errorHandler(response);
    }
    return null;
  }

  static Future<Response?> getQRCode(
      eventId, zoneId, subZoneId, supervisorId) async {
    final response =
        await DioHelper.getData(url: EndPoints.candidateQRCode, query: {
      'eventId': eventId,
      'zoneId': zoneId,
      'subZoneId': subZoneId,
      'supervisorId': 22,
    });
    if (response?.statusCode == 200) {
      return response;
    } else {
      errorHandler(response);
    }
    return null;
  }

  static Future<void> getCandidate() async {
    final response = await DioHelper.getData(url: EndPoints.getCandidate);
    if (response?.statusCode == 200) {
      final candidateModel = CandidateModel.fromJson(response?.data);
      await CacheHelper.saveCandidate(candidateModel.data);
    } else {
      errorHandler(response);
    }
  }

  static Future<Response?> joinEvent(String id) async {
    final response = await DioHelper.postData(
        baseurl: 'https://api.mshware.com/',
        url: EndPoints.joinEvent,
        query: {'eventId': id});
    if (response?.statusCode == 200) {
      CustomSnackBars.showSuccessToast(title: response?.data['message']);
      return response;
    } else {
      errorHandler(response);
    }
    return null;
  }

  static Future<Response?> getMobileCandidate(String id) async {
    final response = await DioHelper.getData(
        url: EndPoints.candidateGetMobile, data: {'candidateId': id});
    if (response?.statusCode == 200) {
      return response;
    } else {
      errorHandler(response);
    }
    return null;
  }

  static Future<Response?> addExperience(String companyName, String projectName,
      String description, String position, int years) async {
    final response =
        await DioHelper.postData(url: EndPoints.candidateAddExperience, data: {
      'companyName': companyName,
      'projectName': projectName,
      'description': description,
      'position': position,
      'years': years,
    });
    if (response?.statusCode == 200) {
      return response;
    } else {
      errorHandler(response);
    }
    return null;
  }

  static Future<Response?> updateExperience(ExperienceItem item) async {
    final response = await DioHelper.updateData(
        url: EndPoints.candidateDeleteExperience,
        query: {'ExperienceId': item.id});
    if (response?.statusCode == 200) {
      CustomSnackBars.showSuccessToast(title: 'تم مسح الخبرة بنجاح');
      AppNavigation.pop();
      return response;
    } else {
      errorHandler(response);
    }
    return null;
  }

  static Future<Response?> deleteExperience(int experienceId) async {
    final response = await DioHelper.deleteData(
        url: EndPoints.candidateDeleteExperience,
        query: {'ExperienceId': experienceId});
    if (response?.statusCode == 200) {
      CustomSnackBars.showSuccessToast(title: 'تم مسح الخبرة بنجاح');
      AppNavigation.pop();
      AppNavigation.pop();
      return response;
    } else {
      errorHandler(response);
    }
    return null;
  }

  static Future<Response?> getCandidateDoc(
    String id,
  ) async {
    final response = await DioHelper.getData(
        url: EndPoints.candidateGetDoc, data: {'candidateId': id});
    if (response?.statusCode == 200) {
      return response;
    } else {
      errorHandler(response);
    }
    return null;
  }

  static Future<Response?> updateIBAN(
    iban,
    bankId,
    hasDelegate,
    delegateID,
    delegateName,
  ) async {
    final response =
        await DioHelper.updateData(url: EndPoints.candidateUpdateIban, query: {
      'bankId': bankId,
      'ibanNumber': iban,
      'hasDelegate': hasDelegate,
      'delegateID': delegateID,
      'delegateName': delegateName,
    });
    if (response?.statusCode == 200) {
      return response;
    } else {}
    return null;
  }

  static Future<Response?> validateIBAN(
    iban,
    bankId,
  ) async {
    final response = await DioHelper.getData(
        url: EndPoints.candidateValidateIban,
        query: {'bankId': bankId, 'ibanNumber': iban});
    if (response?.statusCode == 200) {
      return response;
    }
    return null;
  }

  static Future<Response?> addBank() async {
    final response = await DioHelper.getData(url: '', query: {});
    if (response?.statusCode == 200) {
      return response;
    } else {
      errorHandler(response);
    }
    return null;
  }

  static Future<Response?> getZonesOfEvent(id) async {
    final response = await DioHelper.getData(
        url: EndPoints.getZonesOfEvent, query: {'eventId': id});
    if (response?.statusCode == 200) {
      return response;
    } else {
      errorHandler(response);
    }
    return null;
  }

  static Future<Response?> getSubZonesOfEvent(eventId, zoneId) async {
    final response =
        await DioHelper.getData(url: '${EndPoints.getSubZonesOfEvent}/$zoneId');
    // query: {'zoneId': zoneId, 'eventId': eventId});
    if (response?.statusCode == 200) {
      return response;
    } else {
      errorHandler(response);
    }
    return null;
  }

  static Future<Response?> candidateGetQrString() async {
    final response =
        await DioHelper.getData(url: EndPoints.candidateGetQrString);
    if (response?.statusCode == 200) {
      return response;
    } else {
      errorHandler(response);
    }
    return null;
  }

  static Future<Response?> sendOtp(String number) async {
    final response =
        await DioHelper.postLoginData(url: EndPoints.sendOTP, data: {
      'nationalId': number,
      'userCategory': 5,
    });
    if (response?.statusCode == 200) {
      return response;
    } else {
      errorHandler(response);
    }
    return null;
  }

  static Future<Response?> attendCandidate(String code) async {
    final response =
        await DioHelper.postData(url: EndPoints.attendCandidate, query: {
      'Code': code,
    });
    if (response?.statusCode == 200) {
      return response;
    } else {
      errorHandler(response);
    }
    return null;
  }

  static Future<UserModel?> login(String nationalId, String otp) async {
    final response = await DioHelper.postLoginData(url: EndPoints.login, data: {
      'nationalId': nationalId,
      'otp': otp,
      "firebase_token": '',
      "device_name": Platform.isIOS ? 'ios' : 'android',
    });
    if (response?.statusCode == 200) {
      final user = UserModel.fromJson(response?.data);
      return user;
    }
    return null;
  }

  static Future<void> generateNewToken() async {
    final response =
        await DioHelper.postLoginData(url: EndPoints.refreshToken, data: {
      'ExpiredToken': CacheHelper.getToken,
      'refreshTokenId': CacheHelper.getRefreshToken,
    });

    if (response?.statusCode == 200) {
      final token = response?.data['data']['authToken'];
      final refreshToken = response?.data['data']['refreshTokenId'];
      await CacheHelper.saveToken(token);
      await CacheHelper.saveRefreshToken(refreshToken);
    }
  }

  static Future<Response?> getMyEvents() async {

      final response = await DioHelper.getData(url: EndPoints.getMyEvents);
      if (response?.statusCode == 200) {
        return response;
      } else {
        errorHandler(response);
      }

    return null;
  }

  static Future<Response?> getActiveEvents() async {
    final response = await DioHelper.getData(url: EndPoints.getAllActiveEvents);
    if (response?.statusCode == 200) {
      return response;
    } else {
      errorHandler(response);
    }

    return null;
  }

  static Future<Response?> register({
    required String arabicName,
    required String englishName,
    required String idNumber,
    required String email,
    required int cityId,
    required String dob,
    required int gender,
    required int nationality,
    required int height,
    required int weight,
    required int educationId,
    required int languageId,
    required int departmentId,
    required int tshirtSize,
    required String phoneNumber,
  }) async {
    final response = await DioHelper.putData(
      url: EndPoints.addCandidate,
      data: {
        "fullNameAr": arabicName,
        "fullNameEn": englishName,
        "departmentId": departmentId,
        "educationId": educationId,
        "identity": idNumber,
        "cityId": cityId,
        "dateOfBirth": dob,
        "email": email,
        "languageId": languageId,
        "genderId": gender,
        "nationalityId": nationality,
        "height": height,
        "weight": weight,
        "t_ShirtSize": tshirtSize,
        "mobileNumber": phoneNumber,
        'candidateStatus': 2,
        'statusName': 'string',
      },
    );
    return response;
  }
}
