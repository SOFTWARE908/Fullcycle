import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/base_cubit_state.dart';
import '../../../shared/widgets/custom_snack_bar.dart';
import '../../candidate/data/repository/candidate_repository.dart';

class ForgetPasswordCubit extends Cubit<CubitState> {
  ForgetPasswordCubit() : super(CubitState.initial);

  Future<void> resetPassword(String email) async {
    if (email.isEmpty) {
      CustomSnackBars.showErrorToast(title: "البريد الالكتروني مطلوب");
      return;
    }

    emit(CubitState.loading);

    final response = await CandidateRepository.resetPassword(email);

    if (response?.statusCode == 200) {
      emit(CubitState.done);

      CustomSnackBars.showSuccessToast(
          title: "تم إرسال كلمة المرور عن طريق البريد الالكتروني");
    } else {
      emit(CubitState.error);
      CustomSnackBars.showErrorToast(title: "حدث خطأ أثناء التحديث");
    }
  }
}
