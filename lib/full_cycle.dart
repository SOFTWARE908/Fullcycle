import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/services/cache/cache_helper.dart';
import 'package:fullcycle/services/navigation/navigation.dart';
import 'package:fullcycle/shared/functions/general_functions.dart';
import 'package:fullcycle/shared/themes/app_theme.dart';

import 'bloc_providers.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/home/presentation/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext contexwt) {
    return GestureDetector(
      onTap: GeneralFunctions.hideKeyboard,
      child: MultiBlocProvider(
        providers: providers,
        child: MaterialApp(
          builder: (context, child) =>
              Directionality(textDirection: TextDirection.rtl, child: child!),
          title: 'FullCycle',
          theme: AppThemes.whiteTheme,
          locale: const Locale('ar'),
          debugShowCheckedModeBanner: false,
          navigatorKey: AppNavigation.navigatorKey,
          home:
              CacheHelper.getToken != null ? const HomeScreen() : LoginScreen(),
        ),
      ),
    );
  }
}
