import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fullcycle/services/navigation/navigation.dart';
import 'package:fullcycle/shared/widgets/custom_loading_widget.dart';
import 'package:fullcycle/shared/widgets/custom_snack_bar.dart';
// import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class ProgressDialog {
  static ValueNotifier<double> progress = ValueNotifier(0);

  static void show({String title = 'Loading...'}) {
    progress.value = 0;

    showCupertinoDialog(
      context: AppNavigation.context,
      barrierDismissible: false,
      builder: (_) => CupertinoAlertDialog(
        title: Text(title),
        content: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: ValueListenableBuilder<double>(
            valueListenable: progress,
            builder: (_, value, __) {
              return Column(
                children: [
                  const CustomLoadingWidget(),
                  const SizedBox(height: 12),
                  Text('${(value * 100).toStringAsFixed(0)}%'),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  static void update(double value) {
    progress.value = value.clamp(0, 1);
  }

  static void hide() {
    Navigator.of(AppNavigation.context, rootNavigator: true).pop();
  }
}

class FileDownloader {
  static final Dio _dio = Dio();

  static Future<File?> downloadAndViewFile({
    required String url,
    required String fileName,
  }) async {
    try {
      ProgressDialog.show(title: 'جار التحميل...');

      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/$fileName';
      final file = File(filePath);

      final response = await _dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total > 0) {
            ProgressDialog.update(received / total);
          }
        },
        options: Options(
          followRedirects: true,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Download failed');
      }

      ProgressDialog.hide();
      CustomSnackBars.showSuccessToast(
        title: "تم تنزيل الملف بنجاح",
      );

      return file;
    } catch (e) {
      ProgressDialog.hide();
      CustomSnackBars.showErrorToast(
        title: "فشل تنزيل الملف",
      );
      debugPrint('Download error: $e');
      return null;
    }
  }

  // static Future<void> viewFileFromUrl({
  //   required String url,
  //   required String fileName,
  // }) async {
  //   final dir = await getTemporaryDirectory();
  //   final filePath = '${dir.path}/$fileName';
  //
  //   final dio = Dio();
  //   await dio.download(url, filePath);
  //
  //   await OpenFilex.open(filePath);
  // }
}
