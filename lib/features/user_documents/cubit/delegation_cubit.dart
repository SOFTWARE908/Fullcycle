import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/features/candidate/data/repository/candidate_repository.dart';
import 'package:fullcycle/shared/widgets/custom_snack_bar.dart';

import '../../../shared/model/user_doc_model.dart';

class DelegationCubit extends Cubit<CubitState> {
  DelegationCubit() : super(CubitState.initial);

  String? filePath;
  UserDocModel? delegationModel;

  Future<void> getDelegation() async {
    emit(CubitState.loading);
    try {
      final response = await Repo.getDelegation();

      if (response?.statusCode == 200) {
        delegationModel = UserDocModel.fromJson(response?.data['data']);
        emit(CubitState.done);
      } else {
        emit(CubitState.error);
      }
    } catch (_) {
      emit(CubitState.error);
    }
  }

  Future<void> uploadDelegation(String filePath) async {
    emit(CubitState.loading);
    try {
      final response = await Repo.uploadDelegation(filePath: filePath);

      this.filePath = filePath;
      if (response?.statusCode == 200) {
        CustomSnackBars.showSuccessToast(title: "تم رفع ملف المفوض");
        emit(CubitState.done);
      } else {
        CustomSnackBars.showErrorToast(title: "خطأ في رفع ملف المفوض");

        emit(CubitState.error);
      }
    } catch (_) {
      emit(CubitState.error);
    }
  }

  void remove() {
    filePath = null;
    delegationModel = null;
    emit(CubitState.success);
  }
}
