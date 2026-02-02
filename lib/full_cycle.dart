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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: GeneralFunctions.hideKeyboard,
      child: MultiBlocProvider(
        providers: providers,
        child: MaterialApp(
          title: 'FullCycle',
          debugShowCheckedModeBanner: false,
          navigatorKey: AppNavigation.navigatorKey,
          locale: const Locale('ar', 'EG'),

          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: child!,
            );
          },

          theme: AppThemes.lightTheme,
          home: CacheHelper.token != null ? const HomeScreen() : LoginScreen(),
          // home: HanyScreen(),
        ),
      ),
    );
  }
}
