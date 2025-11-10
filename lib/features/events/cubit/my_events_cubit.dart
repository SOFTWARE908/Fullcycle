import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/features/candidate/data/repository/candidate_repository.dart';
import 'package:fullcycle/features/events/data/model/event_model.dart';

class MyEventsCubit extends Cubit<CubitState> {
  MyEventsCubit() : super(CubitState.initial);

  List<EventModel> events = [];
  Future<void> getMyEvents() async {
    if (events.isNotEmpty) {
      return;
    }
    emit(CubitState.loading);

    try {
      final response = await CandidateRepository.getMyEvents();
      if (response != null) {
        events =
            (response.data['data'] as List).map((e) => EventModel.fromJson(e)).toList();
        emit(CubitState.done);
      } else {
        await CandidateRepository.generateNewToken();

        emit(CubitState.error);
      }
    } catch (e) {
      await CandidateRepository.generateNewToken();

      emit(CubitState.error);
    }
  }
}
