import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/base_cubit_state.dart';
import '../../../services/cache/cache_helper.dart';
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

    if (newPassword.length < 6) {
      CustomSnackBars.showErrorToast(title: "كلمة السر لا تقل عن 6 احرف");
      return;
    }

    emit(CubitState.loading);

    final response = await Repo.changePassword(oldPassword, newPassword);

    if (response?.statusCode == 200) {
      emit(CubitState.done);

      CustomSnackBars.showSuccessToast(title: "تم تغيير كلمة المرور بنجاح");
      CacheHelper.clear();
    } else {
      emit(CubitState.error);
      CustomSnackBars.showErrorToast(title: response?.data['message']);
    }
  }
}
