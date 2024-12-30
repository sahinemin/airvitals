sealed class SignUpEvent {
  const SignUpEvent();
}

final class SignUpSubmitted extends SignUpEvent {
  const SignUpSubmitted({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
