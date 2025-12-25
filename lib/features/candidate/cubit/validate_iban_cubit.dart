import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/features/candidate/data/models/user_bank_data_model.dart';
import 'package:fullcycle/features/candidate/data/repository/candidate_repository.dart';
import 'package:fullcycle/shared/widgets/custom_snack_bar.dart';

class ValidateIbanCubit extends Cubit<CubitState> {
  ValidateIbanCubit() : super(CubitState.initial);

  UserBankDataModel? userBankDataModel;

  Future<void> getUserBankData() async {
    emit(CubitState.loading);
    final response = await CandidateRepository.getBankInfo();

    if (response?.statusCode == 200) {
      userBankDataModel = UserBankDataModel.fromJson(response?.data['data']);

      emit(CubitState.done);
    } else {
      CustomSnackBars.showErrorToast(title: response?.data['message'] ?? "");
      emit(CubitState.error);
    }
  }

  Future<void> validateIban(String iban, bankId) async {
    final response = await CandidateRepository.validateIBAN(iban, bankId);
    if (response?.statusCode == 200) {
      CustomSnackBars.showSuccessToast(title: 'رقم ال IBAN صحيح');
    } else {
      CustomSnackBars.showErrorToast(title: response?.data['msg'] ?? "");
    }
  }

  Future<void> updateIban(
      iban, bankId, hasDelegate, delegateID, delegateName) async {
    emit(CubitState.updateIban);
    final result = await CandidateRepository.updateIBAN(
        iban, bankId, hasDelegate, delegateID, delegateName);
    if (result?.statusCode == 200) {
      emit(CubitState.initial);
      CustomSnackBars.showSuccessToast(title: 'تم تحديث بيانات حسابك');
      // AppNavigation.pop();
    } else {
      CustomSnackBars.showErrorToast(title: 'خطأ في تحديث بيانات حسابك');

      emit(CubitState.error);
    }
  }
}
