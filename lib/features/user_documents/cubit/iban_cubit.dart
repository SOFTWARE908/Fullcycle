import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/features/candidate/data/repository/candidate_repository.dart';
import 'package:fullcycle/shared/widgets/custom_snack_bar.dart';

import '../../../shared/model/user_doc_model.dart';

class IbanCubit extends Cubit<CubitState> {
  IbanCubit() : super(CubitState.initial);

  String? filePath;
  UserDocModel? cvModel;

  Future<void> getIban() async {
    emit(CubitState.loading);
    try {
      final response = await Repo.getIban();

      if (response?.statusCode == 200) {
        cvModel = UserDocModel.fromJson(response?.data['data']);
        emit(CubitState.done);
      } else {
        emit(CubitState.error);
      }
    } catch (_) {
      emit(CubitState.error);
    }
  }

  Future<void> uploadIban(String filePath) async {
    emit(CubitState.loading);
    try {
      final response = await Repo.uploadIban(filePath: filePath);

      this.filePath = filePath;
      if (response?.statusCode == 200) {
        CustomSnackBars.showSuccessToast(title: "تم رفع ملف ال Iban");
        emit(CubitState.done);
      } else {
        CustomSnackBars.showErrorToast(title: "خطأ في رفع ملف ال Iban");

        emit(CubitState.error);
      }
    } catch (_) {
      emit(CubitState.error);
    }
  }

  void remove() {
    filePath = null;
    cvModel = null;
    emit(CubitState.success);
  }
}
