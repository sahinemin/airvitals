import 'package:airvitals/core/presentation/extensions/theme_extension.dart';
import 'package:airvitals/core/presentation/values/dimensions.dart';
import 'package:airvitals/core/routing/route_location.dart';
import 'package:airvitals/core/widgets/email_form_field.dart';
import 'package:airvitals/core/widgets/password_form_field.dart';
import 'package:airvitals/features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:airvitals/features/sign_up/presentation/bloc/sign_up_state.dart';
import 'package:airvitals/features/sign_up/presentation/mixins/sign_up_form_mixin.dart';
import 'package:airvitals/l10n/l10n.dart';
import 'package:airvitals/shared/domain/failures/auth_failures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

part '../widgets/error_text.dart';
part '../widgets/submit_button.dart';

final class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<SignUpBloc>(),
      child: const SignUpView(),
    );
  }
}

final class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

final class _SignUpViewState extends State<SignUpView> with SignUpFormMixin {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.signUpTitle),
      ),
      body: BlocConsumer<SignUpBloc, SignUpState>(
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
                  PasswordFormField(
                    labelText: l10n.confirmPasswordLabel,
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value != passwordController.text) {
                        return l10n.passwordsDoNotMatch;
                      }
                      return null;
                    },
                  ),
                  Dimensions.md.verticalSpace,
                  _ErrorText(state),
                  _SubmitButton(
                    onPressed: state is! SignUpLoading ? onSubmit : null,
                    isLoading: state is SignUpLoading,
                    label: l10n.signUpButtonLabel,
                  ),
                  Dimensions.md.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(l10n.haveAccountMessage),
                      TextButton(
                        onPressed: () => context.go(RouteLocation.signInPath),
                        child: Text(l10n.signInButtonLabel),
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
