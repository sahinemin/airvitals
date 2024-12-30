import 'dart:async';
import 'dart:developer';

import 'package:airvitals/core/di/injection.dart';
import 'package:airvitals/core/presentation/bloc/app_bloc_observer.dart';
import 'package:airvitals/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> bootstrap(Widget Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  WidgetsFlutterBinding.ensureInitialized();  

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Configure dependencies
  configureDependencies();

  Bloc.observer = const AppBlocObserver();

  // Initialize ScreenUtil with design size
  await ScreenUtil.ensureScreenSize();

  runApp(
    ScreenUtilInit(
      designSize: const Size(390, 844), // iPhone 14/15 size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => builder(),
    ),
  );
}
