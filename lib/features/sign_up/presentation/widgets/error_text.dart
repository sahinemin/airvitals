part of '../pages/sign_up_page.dart';

final class _ErrorText extends StatelessWidget {
  const _ErrorText(this.state);

  final SignUpState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return switch (state) {
      SignUpFailure(failure: final failure) => Column(
          children: [
            Text(
              _mapFailureToMessage(failure, l10n),
              style: TextStyle(color: context.colors.error),
            ),
            Dimensions.sm.verticalSpace,
          ],
        ),
      _ => const SizedBox.shrink(),
    };
  }

  String _mapFailureToMessage(AuthFailure failure, AppLocalizations l10n) =>
      switch (failure) {
        EmailAlreadyInUseFailure() => l10n.emailAlreadyInUseError,
        InvalidEmailFailure() => l10n.invalidEmailError,
        WeakPasswordFailure() => l10n.weakPasswordError,
        ServerFailure() => l10n.serverError,
        _ => l10n.serverError,
      };
}
