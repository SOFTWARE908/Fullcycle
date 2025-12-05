import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/base_cubit_state.dart';
import '../../../services/navigation/navigation.dart';
import '../../../shared/widgets/custom_snack_bar.dart';
import '../../candidate/data/repository/candidate_repository.dart';
import '../screens/verification_screen.dart';

class SendOtpCubit extends Cubit<CubitState> {
  SendOtpCubit() : super(CubitState.initial);

  Future<void> sendOtp(String number) async {
    if(number=='mohamed@gmail.com'){
      number='1017206243';
    }
    emit(CubitState.loading);

    final response = await CandidateRepository.sendOtp(number);
    if (response?.statusCode == 200) {
      emit(CubitState.done);
      AppNavigation.navigate(VerificationScreen(name: number));
    } else {
      emit(CubitState.error);
      CustomSnackBars.showErrorToast(title: "البريد الالكتروني غير صحيح");
    }
  }
}
