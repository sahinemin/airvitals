import 'package:airvitals/features/home/data/datasources/room_remote_data_source.dart';
import 'package:airvitals/features/home/domain/entities/room.dart';
import 'package:airvitals/features/home/domain/repositories/room_repository.dart';
import 'package:airvitals/shared/domain/failures/sensor_failures.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RoomRepository)
class RoomRepositoryImpl implements RoomRepository {
  const RoomRepositoryImpl(this._dataSource);

  final RoomRemoteDataSource _dataSource;

  @override
  TaskEither<SensorFailure, Stream<List<Room>>> getRoomsStream(String uid) {
    return TaskEither.tryCatch(
      () async => _dataSource
          .getRoomsStream(uid)
          .map((models) => models.map((model) => model.toDomain()).toList()),
      (error, stackTrace) {
        if (error is FirebaseException) {
          return const ConnectionFailure();
        }
        return const ServerFailure();
      },
    );
  }

  @override
  TaskEither<SensorFailure, Unit> addRoom({
    required String uid,
    required String name,
  }) {
    return TaskEither.tryCatch(
      () async {
        await _dataSource.addRoom(uid, name);
        return unit;
      },
      (error, stackTrace) {
        if (error is FirebaseException) {
          return const ConnectionFailure();
        }
        return const ServerFailure();
      },
    );
  }
}
