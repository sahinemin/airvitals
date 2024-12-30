import 'package:airvitals/shared/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Stream<Option<User>> get authStateChanges;
  TaskOption<User> getCurrentUser();
  Task<void> signOut();
}
