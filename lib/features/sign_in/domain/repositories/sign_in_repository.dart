import 'package:airvitals/shared/domain/failures/auth_failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class SignInRepository {
  TaskEither<AuthFailure, Unit> signIn({
    required String email,
    required String password,
  });
}
