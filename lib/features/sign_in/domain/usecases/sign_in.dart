import 'package:airvitals/features/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:airvitals/shared/domain/failures/auth_failures.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignIn {
  const SignIn(this._repository);

  final SignInRepository _repository;

  TaskEither<AuthFailure, Unit> call({
    required String email,
    required String password,
  }) =>
      _repository.signIn(
        email: email,
        password: password,
      );
}
