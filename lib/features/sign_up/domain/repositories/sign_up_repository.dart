import 'package:airvitals/shared/domain/entities/user.dart';
import 'package:airvitals/shared/domain/failures/auth_failures.dart';
import 'package:fpdart/fpdart.dart';

abstract class SignUpRepository {
  TaskEither<AuthFailure, User> signUp({
    required String email,
    required String password,
  });
}
