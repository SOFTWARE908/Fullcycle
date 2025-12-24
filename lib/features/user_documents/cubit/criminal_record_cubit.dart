import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/base_cubit_state.dart';
import '../../candidate/data/repository/candidate_repository.dart';

class CriminalRecordCubit extends Cubit<CubitState> {
  CriminalRecordCubit() : super(CubitState.initial);

  String? fileUrl;

  Future<void> upload(String filePath) async {
    emit(CubitState.loading);
    try {
      final response = await CandidateRepository.uploadDocument(
        filePath: filePath,
        documentType: "criminalRecord",
      );

      if (response?.statusCode == 200) {
        fileUrl = response?.data?.fileUrl ?? filePath;
        emit(CubitState.done);
      } else {
        emit(CubitState.error);
      }
    } catch (_) {
      emit(CubitState.error);
    }
  }

  void remove() {
    fileUrl = null;
    emit(CubitState.done);
  }
}
