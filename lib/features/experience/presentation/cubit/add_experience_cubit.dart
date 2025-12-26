import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/features/candidate/cubit/get_candidate_experiences_cubit.dart';
import 'package:fullcycle/features/candidate/data/repository/candidate_repository.dart';
import 'package:fullcycle/shared/widgets/custom_snack_bar.dart';

import '../../../../services/navigation/navigation.dart';

class AddExperienceCubit extends Cubit<CubitState> {
  AddExperienceCubit() : super(CubitState.initial);

  addExpeience(
      {required String companyName,
      required String description,
      required String position,
      required int years}) async {
    emit(CubitState.loading);
    final response = await Repo.addExperience(
        companyName: companyName,
        description: description,
        position: position,
        years: years);
    if (response?.statusCode == 200 && AppNavigation.context.mounted) {
      AppNavigation.pop();

      AppNavigation.context
          .read<GetCandidateExperiencesCubit>()
          .getCandidateExperiences();
      emit(CubitState.done);
      CustomSnackBars.showSuccessToast(title: 'تم إضافة الخبرة');
    } else {
      emit(CubitState.error);
    }
  }
}
