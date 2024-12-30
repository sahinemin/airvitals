import 'package:airvitals/features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:airvitals/features/sign_up/presentation/bloc/sign_up_event.dart';
import 'package:airvitals/features/sign_up/presentation/bloc/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin SignUpFormMixin<T extends StatefulWidget> on State<T> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void onSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      context.read<SignUpBloc>().add(
            SignUpSubmitted(
              email: emailController.text,
              password: passwordController.text,
            ),
          );
    }
  }

  void onStateChanged(BuildContext context, SignUpState state) {
    if (state case SignUpSuccess()) {}
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
