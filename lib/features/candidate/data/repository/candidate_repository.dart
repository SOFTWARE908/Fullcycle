import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/features/candidate/data/models/lookup_model.dart';
import 'package:fullcycle/services/cache/cache_helper.dart';
import 'package:fullcycle/services/navigation/navigation.dart';
import 'package:fullcycle/shared/widgets/custom_snack_bar.dart';

import '../../../../core/const/end_points.dart';
import '../../../../services/dio_helper/dio_helper.dart';
import '../../../../services/dio_helper/error_handler.dart';
import '../../../../shared/model/user_model.dart';
import '../../cubit/get_candidate_experiences_cubit.dart';
import '../models/candidate_model.dart';

class Repo {
  static Future<Response?> updateProfile({
    required String fullNameAr,
    required String fullNameEn,
    required String identity,
    required String dateOfBirth,
    required String height,
    required String email,
    required String weight,
    required int? cityId,
    required int? genderId,
    required int? nationalityId,
    required int? languageId,
    required int? departmentId,
    required int? educationId,
    required int? tShirtSize,
  }) {
    return DioHelper.putData(
      url: EndPoints.updateCandidate,
      data: {
        "FullNameAr": fullNameAr,
        "FullNameEn": fullNameEn,
        "identity": identity,
        "dateOfBirth": dateOfBirth,
        "height": height,
        "weight": weight,
        "cityId": cityId,
        "genderId": genderId,
        "nationalityId": nationalityId,
        'Email': email,
        "languageId": languageId,
        "departmentId": departmentId,
        "educationId": educationId,
        "tShirtSize": tShirtSize,
      },
    );
  }

  static Future<Response?> changePassword(
      String oldPassword, String newPassword) async {
    return await DioHelper.postData(
      url: "User/ResetPassword",
      data: {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      },
    );
  }

  static Future<dynamic> resetPassword(String email) async {
    return await DioHelper.getDataWithoutToken(
      url: EndPoints.forgotPassword,
      query: {"email": email},
    );
  }

  static Future<LookupModel?> getLookUps() async {
    final response = await DioHelper.getData(url: EndPoints.getLookUps);

    if (response?.statusCode == 200) {
      return LookupModel.fromJson(response?.data);
    } else {
      errorHandler(response);
    }
    return null;
  }

  static Future<Response?> uploadFesh({required String filePath}) async {
    try {
      final file = File(filePath);

      final formData = FormData.fromMap({
        "Fesh": await MultipartFile.fromFile(file.path,
            filename: file.uri.pathSegments.last),
      });

      final response = await DioHelper.putData(
        url: EndPoints.updateFesh,
        data: formData,
      );

      return response;
    } catch (e) {
      return null;
    }
  }

  static Future<Response?> uploadDelegation({required String filePath}) async {
    try {
      final file = File(filePath);

      final formData = FormData.fromMap({
        "Delegate": await MultipartFile.fromFile(file.path,
            filename: file.uri.pathSegments.last),
      });

      final response = await DioHelper.putData(
        url: EndPoints.updateDelegation,
        data: formData,
      );

      return response;
    } catch (e) {
      return null;
    }
  }

  static Future<Response?> uploadIban({required String filePath}) async {
    try {
      final file = File(filePath);

      final formData = FormData.fromMap({
        "IBan": await MultipartFile.fromFile(file.path,
            filename: file.uri.pathSegments.last),
      });

      final response = await DioHelper.putData(
        url: EndPoints.updateIban,
        data: formData,
      );

      return response;
    } catch (e) {
      return null;
    }
  }

  static Future<Response?> uploadCv({required String filePath}) async {
    try {
      final file = File(filePath);

      final formData = FormData.fromMap({
        "CV": await MultipartFile.fromFile(file.path,
            filename: file.uri.pathSegments.last),
      });

      final response = await DioHelper.putData(
        url: EndPoints.updateCv,
        data: formData,
      );

      return response;
    } catch (e) {
      return null;
    }
  }

  static Future<Response?> getFesh() async {
    try {
      final response = await DioHelper.getData(url: EndPoints.getFesh);
      return response;
    } catch (e) {
      return null;
    }
  }

  static Future<Response?> getIban() async {
    try {
      final response = await DioHelper.getData(url: EndPoints.getIban);
      return response;
    } catch (e) {
      return null;
    }
  }

  static Future<Response?> getDelegation() async {
    try {
      final response = await DioHelper.getData(url: EndPoints.getDelegation);
      return response;
    } catch (e) {
      return null;
    }
  }

  static Future<Response?> getCV() async {
    try {
      final response = await DioHelper.getData(url: EndPoints.getCv);
      return response;
    } catch (e) {
      return null;
    }
  }

  static Future<Response?> uploadDocument({
    required String filePath,
    required String documentType,
  }) async {
    try {
      final file = File(filePath);

      final formData = FormData.fromMap({
        "documentType": documentType,
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
    return response;
  }

  static Future<Response?> getImage() async {
    final response = await DioHelper.getData(url: EndPoints.candidateGetImage);
    if (response?.statusCode == 200) {
      return response;
    } else {
      errorHandler(response);
    }
    return null;
  }

  static Future<Response?> updateImage(filePath) async {
    final file = File(filePath);

    final formData = FormData.fromMap({
      "Pic": await MultipartFile.fromFile(file.path,
          filename: file.uri.pathSegments.last),
    });

    final response =
        await DioHelper.putData(url: EndPoints.updatePic, data: formData);
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
        url: EndPoints.joinEvent, query: {'eventId': id});
    if (response?.statusCode == 200) {
      CustomSnackBars.showSuccessToast(title: 'تم التقديم بنجاح');
      return response;
    } else {
      errorHandler(response);
    }

    return null;
  }

  static Future<Response?> leaveEvent(String id) async {
    final response = await DioHelper.deleteData(
        url: EndPoints.deleteEvent, query: {'eventId': id});
    if (response?.statusCode == 200) {
      CustomSnackBars.showSuccessToast(title: 'تم المغادرة بنجاح');
      AppNavigation.pop();
      return response;
    } else {
      errorHandler(response);
    }

    return null;
  }

  static Future<Response?> addExperience(
      {required String companyName,
      required String description,
      required String position,
      required int years}) async {
    final response =
        await DioHelper.postData(url: EndPoints.candidateAddExperience, data: {
      'companyName': companyName,
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

  static Future<Response?> updateExperience(
      {required String companyName,
      required String description,
      required String position,
      required int years,
      required int id}) async {
    final response = await DioHelper.putData(
        url: EndPoints.candidateUpdateExperience,
        query: {
          'ExperinceId': id,
        },
        data: {
          'companyName': companyName,
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

  static Future<Response?> deleteExperience(int experienceId) async {
    final response = await DioHelper.deleteData(
        url: EndPoints.candidateDeleteExperience,
        query: {'ExperienceId': experienceId});
    if (response?.statusCode == 200 && AppNavigation.context.mounted) {
      CustomSnackBars.showSuccessToast(title: 'تم مسح الخبرة بنجاح');
      AppNavigation.pop();

      AppNavigation.context
          .read<GetCandidateExperiencesCubit>()
          .getCandidateExperiences();
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

  static Future<Response?> getBankInfo() async {
    final response = await DioHelper.getData(url: EndPoints.getBankInfo);
    return response;
  }

  static Future<Response?> updateIban(
    iban,
    bankId,
    hasDelegate,
    delegateID,
    delegateName,
  ) async {
    final response =
        await DioHelper.putData(url: EndPoints.candidateUpdateIban, data: {
      'bankId': bankId,
      'iBan': iban,
      'hasDelegate': hasDelegate,
      'delegateID': delegateID,
      'delegateName': delegateName,
    });
    return response;
  }

  static Future<Response?> validateIBAN(
    iban,
    bankId,
  ) async {
    final response = await DioHelper.getData(
        url: EndPoints.candidateValidateIban,
        query: {'bankId': bankId, 'ibanNumber': iban});
    return response;
  }

  static Future<Response?> getZonesOfEvent(id) async {
    final response =
        await DioHelper.getData(url: '${EndPoints.getZonesOfEvent}/$id');
    if (response?.statusCode == 200) {
      return response;
    } else {
      // errorHandler(response);
    }
    return null;
  }

  static Future<Response?> getSubZonesOfEvent(eventId, zoneId) async {
    final response =
        await DioHelper.getData(url: '${EndPoints.getSubZonesOfEvent}/$zoneId');
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

  static Future<UserModel?> login(String email, String password) async {
    final response = await DioHelper.postLoginData(url: EndPoints.login, data: {
      'email': email,
      'password': password,
      "firebase_token": '',
      'twoFactorCode': '',
      'twoFactorRecoveryCode': '',
      "device_name": Platform.isIOS
          ? 'ios'
          : Platform.isAndroid
              ? 'android'
              : 'not-android-or-ios',
    });
    if (response?.statusCode == 200) {
      await CacheHelper.saveToken(response!.data!['data']['authToken']);
      // await CacheHelper.saveRefreshToken(response.data!['data']['refreshTokenId']);
      await CacheHelper.saveEmail(email);
      await CacheHelper.savePassword(password);
      await Repo.getCandidate();
      final user = UserModel.fromJson(response.data);

      return user;
    }
    return null;
  }

  static Future<void> generateNewToken() async {
    final response = await DioHelper.postData(
        url: EndPoints.refreshToken, data: {'expiredToken': CacheHelper.token});

    if (response?.statusCode == 200) {
      await CacheHelper.saveToken(response?.data['data']['authToken']);
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

  static Future<Response?> getEventsDropdownList() async {
    final response =
        await DioHelper.getData(url: EndPoints.getAllActiveEventsSelectList);
    return response;
  }

  static Future<Response?> getActiveEvents() async {
    final response = await DioHelper.getData(url: EndPoints.getAllActiveEvents);
    return response;
  }

  static Future<Response?> register({
    required String arabicName,
    required String englishName,
    required String idNumber,
    required String password,
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
        'password': password,
        "departmentId": departmentId,
        "educationId": educationId,
        "identity": idNumber,
        "cityId": cityId,
        "dateOfBirth": dob,
        "email": email,
        "languageId": languageId,
        "genderId": gender,
        "nationalityId": nationality,
        "mobileNumber": phoneNumber,
        "height": height,
        "weight": weight,
        "t_ShirtSize": tshirtSize,
        'candidateStatus': 2,
        'statusName': 'string',
      },
    );
    return response;
  }
}
