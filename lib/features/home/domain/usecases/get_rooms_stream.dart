import 'package:airvitals/features/home/domain/entities/room.dart';
import 'package:airvitals/features/home/domain/repositories/room_repository.dart';
import 'package:airvitals/shared/domain/failures/sensor_failures.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRoomsStream {
  const GetRoomsStream(this._repository);

  final RoomRepository _repository;

  TaskEither<SensorFailure, Stream<List<Room>>> call(String uid) =>
      _repository.getRoomsStream(uid);
}
