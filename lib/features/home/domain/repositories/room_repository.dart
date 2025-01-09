import 'package:airvitals/features/home/domain/entities/room.dart';
import 'package:airvitals/shared/domain/failures/sensor_failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class RoomRepository {
  TaskEither<SensorFailure, Stream<List<Room>>> getRoomsStream(String uid);
  TaskEither<SensorFailure, Unit> addRoom({
    required String uid,
    required String name,
  });
}
