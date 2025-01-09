part of '../pages/sign_in_page.dart';

final class _ErrorText extends StatelessWidget {
  const _ErrorText(this.state);

  final SignInState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = ColorScheme.of(context);

    return switch (state) {
      SignInFailure(failure: final failure) => Column(
          children: [
            Text(
              _mapFailureToMessage(failure, l10n),
              style: TextStyle(color: colorScheme.error),
            ),
            Dimensions.sm.verticalSpace,
          ],
        ),
      _ => const SizedBox.shrink(),
    };
  }

  String _mapFailureToMessage(AuthFailure failure, AppLocalizations l10n) =>
      switch (failure) {
        InvalidEmailFailure() => l10n.invalidEmailError,
        WrongPasswordFailure() => l10n.wrongPasswordError,
        UserNotFoundFailure() => l10n.userNotFoundError,
        ServerFailure() => l10n.serverError,
        _ => l10n.serverError,
      };
}
