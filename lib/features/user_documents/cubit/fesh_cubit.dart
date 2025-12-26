import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/features/candidate/data/repository/candidate_repository.dart';
import 'package:fullcycle/shared/widgets/custom_snack_bar.dart';

import '../../../shared/model/user_doc_model.dart';

class FeshCubit extends Cubit<CubitState> {
  FeshCubit() : super(CubitState.initial);

  String? filePath;
  UserDocModel? feshModel;

  Future<void> getFesh() async {
    emit(CubitState.loading);
    try {
      final response = await Repo.getFesh();

      if (response?.statusCode == 200) {
        feshModel = UserDocModel.fromJson(response?.data['data']);
        emit(CubitState.done);
      } else {
        emit(CubitState.error);
      }
    } catch (_) {
      emit(CubitState.error);
    }
  }

  Future<void> uploadFesh(String filePath) async {
    emit(CubitState.loading);
    try {
      final response = await Repo.uploadFesh(filePath: filePath);

      this.filePath = filePath;
      if (response?.statusCode == 200) {
        CustomSnackBars.showSuccessToast(title: "تم رفع الملف الجنائي");
        emit(CubitState.done);
      } else {
        CustomSnackBars.showErrorToast(title: "خطأ في رفع الملف الجنائي");

        emit(CubitState.error);
      }
    } catch (_) {
      emit(CubitState.error);
    }
  }

  void remove() {
    filePath = null;
    feshModel = null;
    emit(CubitState.success);
  }
}
