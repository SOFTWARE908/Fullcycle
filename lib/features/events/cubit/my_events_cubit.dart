import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/features/candidate/data/repository/candidate_repository.dart';
import 'package:fullcycle/features/events/data/model/event_model.dart';
import 'package:fullcycle/shared/widgets/custom_snack_bar.dart';

class MyEventsCubit extends Cubit<CubitState> {
  MyEventsCubit() : super(CubitState.initial);

  List<EventModel> events = [];
  Future<void> getMyEvents() async {
    emit(CubitState.loading);

    try {
      final response = await CandidateRepository.getMyEvents();
      if (response?.statusCode == 200) {
        events = (response?.data['data'] as List)
            .map((e) => EventModel.fromJson(e))
            .toList();
        emit(CubitState.done);
      } else {
        CustomSnackBars.showErrorToast(title: 'لا يوجد فعاليات');
        emit(CubitState.error);
      }
    } catch (e) {
      CustomSnackBars.showErrorToast(title: 'لا يوجد فعاليات');
      emit(CubitState.error);
    }
  }
}
