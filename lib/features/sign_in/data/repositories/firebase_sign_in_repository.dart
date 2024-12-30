import 'package:airvitals/features/sign_in/data/datasources/sign_in_remote_data_source.dart';
import 'package:airvitals/features/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:airvitals/shared/domain/failures/auth_failures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SignInRepository)
class FirebaseSignInRepository implements SignInRepository {
  const FirebaseSignInRepository(this._dataSource);

  final SignInRemoteDataSource _dataSource;

  @override
  TaskEither<AuthFailure, Unit> signIn({
    required String email,
    required String password,
  }) {
    return TaskEither.tryCatch(
      () async {
        await _dataSource.signIn(
          email: email,
          password: password,
        );
        return unit;
      },
      (error, stackTrace) {
        if (error is! FirebaseAuthException) {
          return const ServerFailure();
        }

        return switch (error.code) {
          'invalid-email' => const InvalidEmailFailure(),
          'user-not-found' => const UserNotFoundFailure(),
          'wrong-password' => const WrongPasswordFailure(),
          _ => const ServerFailure(),
        };
      },
    );
  }
}
