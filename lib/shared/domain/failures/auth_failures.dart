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
