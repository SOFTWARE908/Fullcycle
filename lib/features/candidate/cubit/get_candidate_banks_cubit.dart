import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/features/candidate/data/models/user_banks_model.dart';
import 'package:fullcycle/features/candidate/data/repository/candidate_repository.dart';

class GetCandidateBanksCubit extends Cubit<CubitState> {
  GetCandidateBanksCubit() : super(CubitState.initial);

  UserBanksModel? userBanksModel;

  Future<void> getUserBanks() async {
    emit(CubitState.loading);

    try {
      final response = await Repo.getCandidateBanks();
      if (response != null) {
        userBanksModel = UserBanksModel.fromJson(response.data);
        emit(CubitState.done);
      } else {
        emit(CubitState.error);
      }
    } catch (e) {
      emit(CubitState.error);
    }
  }
}
