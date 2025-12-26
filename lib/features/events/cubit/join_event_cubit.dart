import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/services/navigation/navigation.dart';

import '../../candidate/data/repository/candidate_repository.dart';

class JoinEventCubit extends Cubit<CubitState> {
  JoinEventCubit() : super(CubitState.initial);

  Future<void> joinEvent(id) async {
    emit(CubitState.loading);

    try {
      final response = await Repo.joinEvent('$id');
      if (response?.statusCode == 200) {
        emit(CubitState.done);
      } else {
        emit(CubitState.error);
      }
    } catch (e) {
      emit(CubitState.error);
    }
  }

  Future<void> leaveEvent(id) async {
    emit(CubitState.loading);

    try {
      final response = await Repo.leaveEvent('$id');
      if (response?.statusCode == 200) {
        emit(CubitState.done);
        AppNavigation.pop();
      } else {
        emit(CubitState.error);
      }
    } catch (e) {
      emit(CubitState.error);
    }
  }
}
