import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';

import '../../candidate/data/models/lookup_model.dart';
import '../../candidate/data/repository/candidate_repository.dart';

class LookupsCubit extends Cubit<CubitState> {
  LookupsCubit() : super(CubitState.initial);
  LookupModel? lookupModel;

  Future<void> getLookUps() async {
    emit(CubitState.loading);
    lookupModel = await CandidateRepository.getLookUps();

    emit(CubitState.done);
  }
}
