import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/screens/login_screen.dart';
import '../../features/candidate/data/models/candidate_model.dart';
import '../navigation/navigation.dart';

class CacheHelper {
  static late SharedPreferences preferences;

  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveToken(String token) async {
    await preferences.setString('token', token);
  }

  static String? get getToken {
    return preferences.getString('token');
  }

  static Future<void> saveRefreshToken(refreshToken) async {
    await preferences.setString('refreshToken', refreshToken);
  }

  static String? get getRefreshToken {
    return preferences.getString('refreshToken');
  }

  static CandidateData? get getCandidate {
    final data = preferences.getString('candidate');
    final candidateModel = CandidateData.fromJson(json.decode(data!));
    return candidateModel;
  }

  static Future<void> saveCandidate(CandidateData? model) async {
    await preferences.setString('candidate', json.encode(model?.toJson()));
  }

  static Future<void> logOut() async {
    await preferences.clear();
    AppNavigation.navigateOffAll(LoginScreen());
  }
}
