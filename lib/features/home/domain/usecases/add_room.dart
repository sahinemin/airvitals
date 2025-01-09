import 'package:airvitals/features/home/domain/repositories/room_repository.dart';
import 'package:airvitals/shared/domain/failures/sensor_failures.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddRoom {
  const AddRoom(this._repository);

  final RoomRepository _repository;

  TaskEither<SensorFailure, Unit> call({
    required String uid,
    required String name,
  }) =>
      _repository.addRoom(
        uid: uid,
        name: name,
      );
}
