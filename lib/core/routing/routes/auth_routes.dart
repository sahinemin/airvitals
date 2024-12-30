part of '../app_router.dart';

@TypedGoRoute<SignUpRoute>(
  path: '/sign-up',
)
class SignUpRoute extends BaseRoute {
  const SignUpRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SignUpPage();
}
