import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';

import '../../candidate/data/repository/candidate_repository.dart';
import '../data/model/zone_model.dart';

class GetEventZonesCubit extends Cubit<CubitState> {
  GetEventZonesCubit() : super(CubitState.initial);

  List<ZoneModel> zones = [];

  Future<void> getEventZones(id) async {
    if (zones.isNotEmpty) {
      return;
    }
    emit(CubitState.loading);

    try {
      final response = await Repo.getZonesOfEvent(id);
      if (response != null) {
        zones =
            (response.data as List).map((e) => ZoneModel.fromJson(e)).toList();
        emit(CubitState.done);
      } else {
        emit(CubitState.error);
      }
    } catch (e) {
      emit(CubitState.error);
    }
  }
}
