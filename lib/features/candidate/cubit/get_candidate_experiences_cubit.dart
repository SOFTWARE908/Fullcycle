import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/features/candidate/data/models/experiences_model.dart';
import 'package:fullcycle/features/candidate/data/repository/candidate_repository.dart';

class GetCandidateExperiencesCubit extends Cubit<CubitState> {
  GetCandidateExperiencesCubit() : super(CubitState.initial);

  ExperiencesModel? experiencesModel;
  Future<void> getCandidateExperiences() async {
    emit(CubitState.loading);

    try {
      final response = await CandidateRepository.getCandidateExperiences();
      if (response?.statusCode == 200) {
        experiencesModel = ExperiencesModel.fromJson(response?.data);
        emit(CubitState.done);
      } else {
        emit(CubitState.empty);
      }
    } catch (e) {
      emit(CubitState.error);
    }
  }
}
