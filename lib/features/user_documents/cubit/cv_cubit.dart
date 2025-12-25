import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/features/candidate/data/repository/candidate_repository.dart';
import 'package:fullcycle/shared/widgets/custom_snack_bar.dart';

import '../../../shared/model/user_doc_model.dart';

class CvCubit extends Cubit<CubitState> {
  CvCubit() : super(CubitState.initial);

  String? filePath;
  UserDocModel? cvModel;

  Future<void> getCV() async {
    emit(CubitState.loading);
    try {
      final response = await CandidateRepository.getCV();

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

  Future<void> uploadCV(String filePath) async {
    emit(CubitState.loading);
    try {
      final response = await CandidateRepository.uploadCv(filePath: filePath);

      this.filePath = filePath;
      if (response?.statusCode == 200) {
        CustomSnackBars.showSuccessToast(title: "تم رفع السيرة الذاتية");
        emit(CubitState.done);
      } else {
        CustomSnackBars.showErrorToast(title: "خطأ في رفع السيرة الذاتية");

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
