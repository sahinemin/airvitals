import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseModule {
  @singleton
  @preResolve
  Future<FirebaseAuth> get firebaseAuth async {
    final auth = FirebaseAuth.instance;
    if (kIsWeb) {
      await auth.setPersistence(Persistence.INDEXED_DB);
    }
    return auth;
  }

  @singleton
  FirebaseDatabase get firebaseDatabase {
    final database = FirebaseDatabase.instance
      ..databaseURL = 'https://airvitals-project-default-rtdb.firebaseio.com/';
    return database;
  }
}
