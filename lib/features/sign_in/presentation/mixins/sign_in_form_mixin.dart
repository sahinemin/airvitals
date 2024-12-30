import 'package:airvitals/core/routing/app_router.dart';
import 'package:airvitals/features/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:airvitals/features/sign_in/presentation/bloc/sign_in_event.dart';
import 'package:airvitals/features/sign_in/presentation/bloc/sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin SignInFormMixin<T extends StatefulWidget> on State<T> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void onSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      context.read<SignInBloc>().add(
            SignInSubmitted(
              email: emailController.text,
              password: passwordController.text,
            ),
          );
    }
  }

  void onStateChanged(BuildContext context, SignInState state) {
    if (state case SignInSuccess()) {
      const HomeRoute().go(context);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }
}
