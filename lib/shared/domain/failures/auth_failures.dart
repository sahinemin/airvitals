sealed class AuthFailure {
  const AuthFailure();
}

final class InvalidEmailFailure extends AuthFailure {
  const InvalidEmailFailure();
}

final class WrongPasswordFailure extends AuthFailure {
  const WrongPasswordFailure();
}

final class UserNotFoundFailure extends AuthFailure {
  const UserNotFoundFailure();
}

final class EmailAlreadyInUseFailure extends AuthFailure {
  const EmailAlreadyInUseFailure();
}

final class WeakPasswordFailure extends AuthFailure {
  const WeakPasswordFailure();
}

final class ServerFailure extends AuthFailure {
  const ServerFailure();
}
