import 'package:airvitals/core/di/injection.dart';
import 'package:airvitals/core/presentation/styles/app_theme.dart';
import 'package:airvitals/core/routing/app_router.dart';
import 'package:airvitals/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      rebuildFactor: (old, data) => old.size != data.size,
      builder: (_, child) => MaterialApp.router(
        routerConfig: getIt<AppRouter>().router,
        theme: AppTheme.dark,
        darkTheme: AppTheme.dark,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
