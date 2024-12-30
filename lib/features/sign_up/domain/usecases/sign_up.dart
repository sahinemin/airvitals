import 'package:airvitals/features/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:airvitals/shared/domain/entities/user.dart';
import 'package:airvitals/shared/domain/failures/auth_failures.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUp {
  const SignUp(this._repository);

  final SignUpRepository _repository;

  TaskEither<AuthFailure, User> call({
    required String email,
    required String password,
  }) =>
      _repository.signUp(
        email: email,
        password: password,
      );
}
