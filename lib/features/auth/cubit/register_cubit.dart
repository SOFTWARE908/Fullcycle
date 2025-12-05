import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/features/auth/screens/verification_screen.dart';
import 'package:fullcycle/features/candidate/data/repository/candidate_repository.dart';
import 'package:fullcycle/services/navigation/navigation.dart';
import 'package:fullcycle/shared/widgets/custom_snack_bar.dart';

class RegisterCubit extends Cubit<CubitState> {
  RegisterCubit() : super(CubitState.initial);

  Future<void> register({
    required String arabicName,
    required String englishName,
    required String idNumber,
    required String password,
    required int cityId,
    required String dob,
    required int gender,
    required int nationality,
    required String email,
    required int height,
    required int weight,
    required int tshirtSize,
    required int educationId,
    required int languageId,
    required int departmentId,

    required String phoneNumber,
  }) async {
    emit(CubitState.loading);

    final response = await CandidateRepository.register(
      arabicName: arabicName,
      englishName: englishName,
      password: password,
      idNumber: idNumber,
      departmentId: departmentId,
      educationId: educationId,
      languageId: languageId,
      email: email,
      cityId: cityId,
      dob: dob,
      gender: gender,
      nationality: nationality,
      height: height,
      weight: weight,
      tshirtSize: tshirtSize,
      phoneNumber: phoneNumber,
    );

    if (response?.statusCode == 200) {
      emit(CubitState.done);
      // final candidateModel = CandidateModel.fromJson(response?.data);
      // await CacheHelper.saveCandidate(candidateModel.data);
      AppNavigation.navigateOffAll(  LoginPage());
      CustomSnackBars.showSuccessToast(title:'تم انشاء الحساب بنجاح');
    } else {
      emit(CubitState.error);
      CustomSnackBars.showErrorToast(title: response?.data['message']??"error");
    }
  }
}
