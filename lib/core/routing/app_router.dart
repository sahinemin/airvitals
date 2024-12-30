import 'package:airvitals/core/routing/base_route.dart';
import 'package:airvitals/core/routing/route_location.dart';
import 'package:airvitals/features/home/presentation/pages/home_page.dart';
import 'package:airvitals/features/sign_in/presentation/pages/sign_in_page.dart';
import 'package:airvitals/features/sign_up/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

part 'app_router.g.dart';
part 'routes/app_routes.dart';

@singleton
class AppRouter {
  const AppRouter();

  GoRouter get router => GoRouter(
        initialLocation: '/sign-up',
        routes: $appRoutes,
      );
}
