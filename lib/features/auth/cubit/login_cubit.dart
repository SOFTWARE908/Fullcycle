import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/features/candidate/data/repository/candidate_repository.dart';
import 'package:fullcycle/services/navigation/navigation.dart';

import '../../../core/cubit/base_cubit_state.dart';
import '../../../shared/widgets/custom_snack_bar.dart';
import '../../home/presentation/screens/home_screen.dart';

class LoginCubit extends Cubit<CubitState> {
  LoginCubit() : super(CubitState.initial);

  Future<void> login(String email, String password) async {
    emit(CubitState.loading);
    final response = await CandidateRepository.login(email, password);
    if (response?.status == 200) {
      emit(CubitState.done);

      AppNavigation.pushRemoveAll(const HomeScreen());
    } else {
      emit(CubitState.error);
      CustomSnackBars.showErrorToast(title: "تسجيل دخول خاطئ");
    }
  }
}
