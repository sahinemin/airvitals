import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';

abstract class SignUpRemoteDataSource {
  Future<firebase_auth.User> signUp({
    required String email,
    required String password,
  });
}

@Injectable(as: SignUpRemoteDataSource)
class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  SignUpRemoteDataSourceImpl(this._firebaseAuth);

  final firebase_auth.FirebaseAuth _firebaseAuth;

  @override
  Future<firebase_auth.User> signUp({
    required String email,
    required String password,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential.user == null) {
      throw Exception('User creation failed');
    }

    return userCredential.user!;
  }
}
