import 'package:airvitals/shared/domain/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

extension UserMapper on firebase_auth.User {
  User toDomain() => User(
        id: uid,
        email: email!,
        displayName: displayName,
        photoUrl: photoURL,
      );
}
