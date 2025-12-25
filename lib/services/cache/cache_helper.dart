import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fullcycle/features/auth/screens/login_screen.dart';
import 'package:fullcycle/services/navigation/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/candidate/data/models/candidate_model.dart';

class CacheHelper {
  static late SharedPreferences _prefs;

  static final ValueNotifier<String?> tokenNotifier = ValueNotifier(null);

  static final ValueNotifier<String?> refreshTokenNotifier =
      ValueNotifier(null);

  static final ValueNotifier<CandidateData?> candidateNotifier =
      ValueNotifier(null);

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();

    tokenNotifier.value = _prefs.getString('token');
    refreshTokenNotifier.value = _prefs.getString('refreshToken');
    final candidateJson = _prefs.getString('candidate');
    if (candidateJson != null) {
      candidateNotifier.value =
          CandidateData.fromJson(json.decode(candidateJson));
    }
  }

  static Future<void> saveToken(String token) async {
    await _prefs.setString('token', token);
    tokenNotifier.value = token;
  }

  static Future<void> saveEmail(String email) async {
    await _prefs.setString('email', email);
  }

  static Future<void> savePassword(String password) async {
    await _prefs.setString('password', password);
  }

  static String? get token => tokenNotifier.value;
  static String? get email => _prefs.getString('email');
  static String? get password => _prefs.getString('password');

  static Future<void> saveRefreshToken(String token) async {
    await _prefs.setString('refreshToken', token);
    refreshTokenNotifier.value = token;
  }

  static String? get refreshToken => refreshTokenNotifier.value;

  static Future<void> saveCandidate(CandidateData? model) async {
    if (model == null) {
      await _prefs.remove('candidate');
      candidateNotifier.value = null;
    } else {
      await _prefs.setString(
        'candidate',
        json.encode(model.toJson()),
      );
      candidateNotifier.value = model;
    }
  }

  static CandidateData? get candidate => candidateNotifier.value;

  /// =====================
  /// Clear / Logout
  /// =====================
  static Future<void> clear() async {
    await _prefs.clear();
    tokenNotifier.value = null;
    refreshTokenNotifier.value = null;
    candidateNotifier.value = null;
    AppNavigation.pushRemoveAll(LoginScreen());
  }
}
