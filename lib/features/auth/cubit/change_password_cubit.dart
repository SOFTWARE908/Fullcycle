import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/features/auth/screens/login_screen.dart';
import 'package:fullcycle/services/navigation/navigation.dart';

import '../../../core/cubit/base_cubit_state.dart';
import '../../../shared/widgets/custom_snack_bar.dart';
import '../../candidate/data/repository/candidate_repository.dart';

class ChangePasswordCubit extends Cubit<CubitState> {
  ChangePasswordCubit() : super(CubitState.initial);

  Future<void> changePassword(
      {required String oldPassword, required String newPassword}) async {
    if (oldPassword.isEmpty) {
      CustomSnackBars.showErrorToast(title: "كلمة السر القديمة مطلوبة");
      return;
    }
    if (newPassword.isEmpty) {
      CustomSnackBars.showErrorToast(title: "كلمة السر الجديدة مطلوبة");
      return;
    }

    emit(CubitState.loading);

    final response =
        await CandidateRepository.changePassword(oldPassword, newPassword);

    if (response?.statusCode == 200) {
      emit(CubitState.done);

      CustomSnackBars.showSuccessToast(title: "تم تغيير كلمة المرور بنجاح");
      AppNavigation.pushRemoveAll(LoginScreen());
    } else {
      emit(CubitState.error);
      CustomSnackBars.showErrorToast(title: response?.data['message']);
    }
  }
}
