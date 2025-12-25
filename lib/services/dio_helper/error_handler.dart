import 'package:dio/dio.dart';
import 'package:fullcycle/services/cache/cache_helper.dart';

import '../../features/candidate/data/repository/candidate_repository.dart';
import '../../shared/model/error_model.dart';
import '../../shared/widgets/custom_snack_bar.dart';

Future<void> errorHandler(Response? response) async {
  if (response?.statusCode == 400) {
    final errorModel = ErrorModel.fromJson(response?.data);

    CustomSnackBars.showErrorToast(
        title: errorModel.message ?? 'Bad request error');
  } else if (response?.statusCode == 500) {
    CustomSnackBars.showErrorToast(title: 'مشكلة في الخادم');
  } else if (response?.statusCode == 422 || response?.statusCode == 401) {
    await CandidateRepository.login(CacheHelper.email!, CacheHelper.password!);
  } else if (response?.statusCode == 404) {
    CustomSnackBars.showErrorToast(title: 'Not found error');
  }
}
