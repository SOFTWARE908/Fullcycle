abstract class GetQrCodeState {}

class GetQrCodeStateInitial extends GetQrCodeState {}

class GetQrCodeStateLoading extends GetQrCodeState {}

class GetQrCodeStateError extends GetQrCodeState {
  final String message;
  GetQrCodeStateError(this.message);
}

class GetQrCodeStateDone extends GetQrCodeState {}
