import 'package:airvitals/shared/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, User>> signUp({
    required String email,
    required String password,
  });
}

sealed class AuthFailure {
  const AuthFailure();
}

class EmailAlreadyInUseFailure extends AuthFailure {
  const EmailAlreadyInUseFailure();
}

class WeakPasswordFailure extends AuthFailure {
  const WeakPasswordFailure();
}

class InvalidEmailFailure extends AuthFailure {
  const InvalidEmailFailure();
}

class ServerFailure extends AuthFailure {
  const ServerFailure();
}
