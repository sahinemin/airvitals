import 'package:airvitals/features/sign_up/data/datasources/sign_up_remote_data_source.dart';
import 'package:airvitals/features/sign_up/data/mappers/user_mapper.dart';
import 'package:airvitals/features/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:airvitals/shared/domain/entities/user.dart';
import 'package:airvitals/shared/domain/failures/auth_failures.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SignUpRepository)
class SignUpRepositoryImpl implements SignUpRepository {
  const SignUpRepositoryImpl(this._remoteDataSource);

  final SignUpRemoteDataSource _remoteDataSource;

  @override
  TaskEither<AuthFailure, User> signUp({
    required String email,
    required String password,
  }) {
    return TaskEither.tryCatch(
      () async {
        final firebaseUser = await _remoteDataSource.signUp(
          email: email,
          password: password,
        );
        return firebaseUser.toDomain();
      },
      (error, _) => switch (error) {
        firebase_auth.FirebaseAuthException(code: 'email-already-in-use') =>
          const EmailAlreadyInUseFailure(),
        firebase_auth.FirebaseAuthException(code: 'invalid-email') =>
          const InvalidEmailFailure(),
        firebase_auth.FirebaseAuthException(code: 'weak-password') =>
          const WeakPasswordFailure(),
        _ => const ServerFailure(),
      },
    );
  }
}
