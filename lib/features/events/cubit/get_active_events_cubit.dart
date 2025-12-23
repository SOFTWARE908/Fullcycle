import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/features/candidate/data/repository/candidate_repository.dart';
import 'package:fullcycle/features/events/data/model/event_model.dart';

class GetActiveEventsCubit extends Cubit<CubitState> {
  GetActiveEventsCubit() : super(CubitState.initial);

  List<EventModel> events = [];
  List<EventModel> filteredEvents = [];
  Future<void> getActiveEvents() async {
    emit(CubitState.loading);
    try {
      final response = await CandidateRepository.getActiveEvents();
      if (response?.data['status'] == 401) {
        emit(CubitState.userInactive);
      } else if (response?.data['status'] == 400) {
        emit(CubitState.empty);
      } else if (response?.statusCode == 200) {
        events = (response?.data['data'] as List)
            .map((e) => EventModel.fromJson(e))
            .toList();
        filteredEvents = List<EventModel>.from(events);
        emit(CubitState.done);
      } else {
        await CandidateRepository.generateNewToken();
        emit(CubitState.error);
      }
    } catch (_) {
      await CandidateRepository.generateNewToken();
      emit(CubitState.error);
    }
  }

  void searchEvents(String query) {
    emit(CubitState.loading);
    if (query.trim().isEmpty) {
      filteredEvents = List<EventModel>.from(events);
    } else {
      final q = query.toLowerCase();
      filteredEvents = events.where((event) {
        final n1 = (event.eventName ?? '').toLowerCase();
        final n2 = (event.id.toString()).toLowerCase();
        final n3 = (event.cityName ?? '').toLowerCase();
        return n1.contains(q) || n2.contains(q) || n3.contains(q);
      }).toList();
    }
    emit(CubitState.done);
  }
}
