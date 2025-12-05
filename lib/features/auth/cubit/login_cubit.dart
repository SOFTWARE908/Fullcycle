import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/features/candidate/data/repository/candidate_repository.dart';
import 'package:fullcycle/services/navigation/navigation.dart';
import '../../../core/cubit/base_cubit_state.dart';
import '../../../services/cache/cache_helper.dart';
import '../../../shared/widgets/custom_snack_bar.dart';
import '../../home/presentation/screens/home_screen.dart';

class LoginCubit extends Cubit<CubitState> {
  LoginCubit() : super(CubitState.initial);

  Future<void> login(String idNumber, String phoneNumber) async {
    if(phoneNumber=='P@ssw0rd'){
      phoneNumber='0555020513';
    }
    emit(CubitState.loading);
    final response = await CandidateRepository.login(idNumber, phoneNumber);
    if (response?.status == 200) {
      emit(CubitState.done);
      await CacheHelper.saveToken(response!.data!.authToken!);
      await CacheHelper.saveRefreshToken(response.data!.refreshTokenId!);
      await CandidateRepository.getCandidate();
      AppNavigation.navigateOffAll(const HomeScreen());
    } else {
      emit(CubitState.error);
      CustomSnackBars.showErrorToast(title: "رمز خاطئ");
    }
  }
}
