import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/features/candidate/data/repository/candidate_repository.dart';

class CvCubit extends Cubit<CubitState> {
  CvCubit() : super(CubitState.initial);

  String? filePath;

  Future<void> upload(String filePath) async {
    emit(CubitState.loading);
    try {
      final response = await CandidateRepository.uploadCv(filePath: filePath);

      this.filePath = filePath;
      if (response?.statusCode == 200) {
        emit(CubitState.done);
      } else {
        emit(CubitState.error);
      }
    } catch (_) {
      emit(CubitState.error);
    }
  }

  void remove() {
    filePath = null;
    emit(CubitState.done);
  }
}
