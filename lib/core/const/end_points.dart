class EndPoints {
  static String baseUrl = 'https://api.mshware.com/api/';

  static const String login = 'User/login';

  static const String refreshToken = 'User/RefreshToken';
  static const String candidateQRCode = 'CandidateAttendance/GenerateQr';
  static const String candidateAddExperience = 'Experince/AddExperience';
  static const String candidateDeleteExperience = 'Experince/DeleteExperience';
  static const String candidateUpdateExperience = 'Experince/UpdateExperience';
  static const String candidateGetDoc = 'Candidate/GetDoc';
  static const String updateCv = 'Files/UpdateCv';
  static const String getFesh = 'Files/GetFesh';
  static const String getCv = 'Files/GetCv';
  static const String candidateValidateIban = 'Candidate/ValidateIBan';
  static const String candidateUpdateIban = 'Candidate/UpdateBankInfo';
  static const String candidateGetBanks = 'Candidate/getbanks';
  static const String candidateGetImage = 'Files/GetPic';
  static const String candidateGetExperience = 'Experince/getExperience';
  static const String getCandidate = 'Candidate/GetCandidate';
  static const String getAllActiveEvents = 'Event/GetAllActiveEvents';
  static const String getMyEvents = 'EventCandidate/GetAllActiveEventsForUser';
  static const String getLookUps = 'LookUps/GetCandidateLookups';
  static const String getZonesOfEvent = 'LookUps/GetEventZonesLookups';
  static const String getSubZonesOfEvent = 'LookUps/GetEventSubZonesLookups';
  static const String candidateGetQrString = 'Candidate/GetQrString';
  static const String updateCandidate = 'Candidate/UpdateCandidate';
  static const String addCandidate = 'Candidate/AddCandidate';
  static const String updateFesh = 'Files/UpdateFesh';
  static const String attendCandidate = 'CandidateAttendance/AttendCandidate';
  static const String joinEvent = 'EventCandidate/AssignEventToCandidate';
  static const String deleteEvent = 'EventCandidate/DeleteCandidateFromEvent';
  static const String updatePic = 'Files/UpdatePic';
  static const String forgotPassword = 'User/ForgotPassword';
  static const String getBankInfo = 'Candidate/GetBanKInfo';
  static const String getAllActiveEventsSelectList =
      'Event/GetAllActiveEventsSelectList';
}
