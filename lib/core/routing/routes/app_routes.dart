part of '../app_router.dart';

@TypedGoRoute<SignUpRoute>(
  path: RouteLocation.signUpPath,
)
class SignUpRoute extends BaseRoute {
  const SignUpRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SignUpPage();
}

@TypedGoRoute<SignInRoute>(
  path: RouteLocation.signInPath,
)
class SignInRoute extends BaseRoute {
  const SignInRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SignInPage();
}

@TypedGoRoute<HomeRoute>(
  path: RouteLocation.homePath,
)
class HomeRoute extends BaseRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}
