import 'package:airvitals/features/home/data/models/room_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

abstract interface class RoomRemoteDataSource {
  Stream<List<RoomModel>> getRoomsStream(String uid);
  Future<void> addRoom(String uid, String name);
  Stream<RoomModel> getRoomStream(String uid, String roomId);
}

@Injectable(as: RoomRemoteDataSource)
class FirebaseRoomRemoteDataSource implements RoomRemoteDataSource {
  const FirebaseRoomRemoteDataSource(this._database);

  final FirebaseDatabase _database;

  @override
  Stream<List<RoomModel>> getRoomsStream(String uid) {
    final ref = _database.ref('$uid/rooms');
    return ref.onValue.map((event) {
      if (event.snapshot.value == null) return [];

      final value = event.snapshot.value! as Map<Object?, Object?>;
      return value.entries.where((entry) => entry.value != null).map((entry) {
        final key = entry.key.toString();
        final data = Map<String, dynamic>.from(
          (entry.value! as Map<Object?, Object?>)
              .map((key, value) => MapEntry(key.toString(), value)),
        );
        return RoomModel.fromJson({
          'id': key,
          'name': key,
          'temperature': data['temperature'] ?? 0.0,
          'humidity': data['humidity'] ?? 0.0,
        });
      }).toList();
    });
  }

  @override
  Future<void> addRoom(String uid, String name) async {
    final ref = _database.ref('$uid/rooms/$name');
    await ref.set({
      'temperature': 0.0,
      'humidity': 0.0,
    });
  }

  @override
  Stream<RoomModel> getRoomStream(String uid, String roomId) {
    final ref = _database.ref('$uid/rooms/$roomId');
    return ref.onValue.map((event) {
      if (event.snapshot.value == null) {
        throw Exception('Room not found');
      }

      final value = event.snapshot.value! as Map<Object?, Object?>;
      final data = Map<String, dynamic>.from(
        value.map((key, value) => MapEntry(key.toString(), value)),
      );

      return RoomModel.fromJson({
        'id': roomId,
        ...data,
      });
    });
  }
}
