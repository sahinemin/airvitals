import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class BaseRoute extends GoRouteData {
  const BaseRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: build(context, state),
      transitionDuration: Durations.medium4,
      reverseTransitionDuration: Durations.medium4,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Check if this is a secondary transition
        if (secondaryAnimation.status != AnimationStatus.dismissed) {
          // Secondary transition - slide from bottom
          return SlideTransition(
            position: secondaryAnimation.drive(
              Tween<Offset>(
                begin: Offset.zero,
                end: const Offset(0, -0.25),
              ).chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        }

        // Primary transition - fade and slide from right
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(
              Tween<Offset>(
                begin: const Offset(0.25, 0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          ),
        );
      },
    );
  }
}
