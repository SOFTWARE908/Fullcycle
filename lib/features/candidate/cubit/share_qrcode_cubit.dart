import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/features/candidate/data/repository/candidate_repository.dart';

import '../../../shared/model/qr_profile_model.dart';

class QrProfileCubit extends Cubit<CubitState> {
  QrProfileCubit() : super(CubitState.initial);

  QrProfileModel? qrProfileModel;

  Future<void> getQRCode() async {
    emit(CubitState.loading);

    try {
      final response = await Repo.candidateGetQrString();
      if (response?.statusCode == 200) {
        qrProfileModel = QrProfileModel.fromJson(response?.data);
        emit(CubitState.done);
      } else {
        emit(CubitState.error);
      }
    } catch (e) {
      emit(CubitState.error);
    }
  }
}
