import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract interface class SignInRemoteDataSource {
  Future<void> signIn({
    required String email,
    required String password,
  });
}

@Injectable(as: SignInRemoteDataSource)
class FirebaseSignInRemoteDataSource implements SignInRemoteDataSource {
  const FirebaseSignInRemoteDataSource(this._auth);

  final FirebaseAuth _auth;

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
