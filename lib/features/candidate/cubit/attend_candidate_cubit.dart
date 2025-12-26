import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/features/candidate/data/repository/candidate_repository.dart';
import 'package:fullcycle/services/navigation/navigation.dart';
import 'package:fullcycle/shared/widgets/custom_snack_bar.dart';

class AttendCandidateCubit extends Cubit<CubitState> {
  AttendCandidateCubit() : super(CubitState.initial);

  Future<void> attendCandidate(code, [bool? back]) async {
    emit(CubitState.loading);

    final response = await Repo.attendCandidate(code);
    if (response?.statusCode == 200) {
      CustomSnackBars.showSuccessToast(title: 'تم التحضير بنجاح');
      emit(CubitState.done);
    } else {
      emit(CubitState.error);
    }
    if (back == true) {
      AppNavigation.pop();
    }
  }
}
