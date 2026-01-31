import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/features/candidate/data/repository/candidate_repository.dart';
import 'package:fullcycle/shared/widgets/custom_snack_bar.dart';

import '../../../services/cache/cache_helper.dart';
import '../../candidate/data/models/candidate_model.dart';

class EditProfileCubit extends Cubit<CubitState> {
  EditProfileCubit() : super(CubitState.initial);

  editProfile({
    required String fullNameAr,
    required String fullNameEn,
    required String identity,
    required String dateOfBirth,
    required String height,
    required String weight,
    required String email,
    required int? cityId,
    required int? genderId,
    required int? nationalityId,
    required int? languageId,
    required int? departmentId,
    required int? educationId,
    required int? tshirtSize,
  }) async {
    emit(CubitState.loading);

    final response = await Repo.updateProfile(
      fullNameAr: fullNameAr,
      fullNameEn: fullNameEn,
      identity: identity,
      dateOfBirth: dateOfBirth,
      email: email,
      height: height,
      weight: weight,
      cityId: cityId,
      genderId: genderId,
      nationalityId: nationalityId,
      languageId: languageId,
      departmentId: departmentId,
      educationId: educationId,
      tShirtSize: tshirtSize,
    );

    if (response?.data['status'] == 200) {
      final email = (response?.data['data']['email']);
      emit(CubitState.done);

      CustomSnackBars.showSuccessToast(title: 'تم تعديل الملف الشخصي بنجاح');
      await CacheHelper.saveEmail(email);
      await CacheHelper.saveCandidate(
          CandidateData.fromJson(response?.data['data']));
    } else {
      CustomSnackBars.showErrorToast(
        title: response?.data['message'],
      );
      emit(CubitState.error);
    }
  }
}
