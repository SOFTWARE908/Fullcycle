import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/features/candidate/data/models/qr_code_model.dart';
import 'package:fullcycle/features/candidate/data/repository/candidate_repository.dart';

import '../../events/data/model/zone_model.dart';
import '../get_qr_code_state.dart';

class GetCandidateQRCodeCubit extends Cubit<GetQrCodeState> {
  GetCandidateQRCodeCubit() : super(GetQrCodeStateInitial());

  QRCodeModel? qrCodeModel;

  bool qrLoading = false;
  List<ZoneModel> events = [];
  List<ZoneModel> zones = [];
  List<ZoneModel> subZones = [];

  getEvents() async {
    emit(GetQrCodeStateLoading());

    final response = await CandidateRepository.getEventsDropdownList();

    if (response?.data['status'] == 400) {
      emit(GetQrCodeStateError(response?.data['message']));
    } else if (response?.data['status'] == 200) {
      final zonesData = response?.data['data'] as List? ?? [];
      events = zonesData.map((e) => ZoneModel.fromJson(e)).toList();
      emit(GetQrCodeStateDone());
    } else {
      emit(GetQrCodeStateError(response?.data['message']));
    }
  }

  getZones(eventId) async {
    emit(GetQrCodeStateLoading());

    final response = await CandidateRepository.getZonesOfEvent(eventId);
    if (response?.statusCode == 200) {
      final zonesData = response?.data['data']?['zones'] as List? ?? [];
      zones = zonesData.map((e) => ZoneModel.fromJson(e)).toList();
      emit(GetQrCodeStateDone());
    } else {
      emit(GetQrCodeStateError(response?.data['message']));
    }
  }

  clearQRCode() {
    qrCodeModel = null;
    emit(GetQrCodeStateDone());
  }

  getSubZones(eventId, zoneId) async {
    emit(GetQrCodeStateLoading());

    final response =
        await CandidateRepository.getSubZonesOfEvent(eventId, zoneId);
    if (response?.statusCode == 200) {
      final zonesData = response?.data['data']?['subZones'] as List? ?? [];
      subZones = zonesData.map((e) => ZoneModel.fromJson(e)).toList();
      emit(GetQrCodeStateDone());
    } else {
      emit(GetQrCodeStateError(response?.data['message']));
    }
  }

  Future<void> getQRCode(eventId, zoneId, subZoneId, supervisorId) async {
    qrLoading = true;
    emit(GetQrCodeStateLoading());

    final response = await CandidateRepository.getQRCode(
        eventId, zoneId, subZoneId, supervisorId);
    if (response != null) {
      qrCodeModel = QRCodeModel.fromJson(response.data);

      qrLoading = false;

      emit(GetQrCodeStateDone());
    } else {
      qrLoading = false;

      emit(GetQrCodeStateError(response?.data['message']));
    }
  }
}
