import 'package:airvitals/shared/domain/failures/auth_failures.dart';

sealed class SignUpState {
  const SignUpState();
}

final class SignUpInitial extends SignUpState {
  const SignUpInitial();
}

final class SignUpLoading extends SignUpState {
  const SignUpLoading();
}

final class SignUpSuccess extends SignUpState {
  const SignUpSuccess();
}

final class SignUpFailure extends SignUpState {
  const SignUpFailure(this.failure);

  final AuthFailure failure;
}
