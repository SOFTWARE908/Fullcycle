import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fullcycle/full_cycle.dart';
import 'package:fullcycle/services/cache/cache_helper.dart';
import 'package:fullcycle/services/dio_helper/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await CacheHelper.init();
  DioHelper.init();
  runApp(const MyApp());
}
