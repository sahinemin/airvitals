import 'package:airvitals/core/presentation/values/dimensions.dart';
import 'package:airvitals/core/routing/route_location.dart';
import 'package:airvitals/core/widgets/email_form_field.dart';
import 'package:airvitals/core/widgets/password_form_field.dart';
import 'package:airvitals/features/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:airvitals/features/sign_in/presentation/bloc/sign_in_state.dart';
import 'package:airvitals/features/sign_in/presentation/mixins/sign_in_form_mixin.dart';
import 'package:airvitals/l10n/l10n.dart';
import 'package:airvitals/shared/domain/failures/auth_failures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

part '../widgets/error_text.dart';
part '../widgets/submit_button.dart';

final class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<SignInBloc>(),
      child: const SignInView(),
    );
  }
}

final class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

final class _SignInViewState extends State<SignInView> with SignInFormMixin {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.signInTitle),
      ),
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: onStateChanged,
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(Dimensions.md.w),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Dimensions.lg.verticalSpace,
                  EmailFormField(
                    emailController: emailController,
                    labelText: l10n.emailLabel,
                  ),
                  Dimensions.md.verticalSpace,
                  PasswordFormField(
                    labelText: l10n.passwordLabel,
                    controller: passwordController,
                  ),
                  Dimensions.md.verticalSpace,
                  _ErrorText(state),
                  _SubmitButton(
                    onPressed: state is! SignInLoading ? onSubmit : null,
                    isLoading: state is SignInLoading,
                    label: l10n.signInButtonLabel,
                  ),
                  Dimensions.md.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(l10n.noAccountMessage),
                      TextButton(
                        onPressed: () => context.go(RouteLocation.signUpPath),
                        child: Text(l10n.signUpButtonLabel),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
