import 'package:airvitals/features/home/data/datasources/sensor_data_remote_data_source.dart';
import 'package:airvitals/features/home/domain/entities/sensor_data.dart';
import 'package:airvitals/features/home/domain/repositories/sensor_data_repository.dart';
import 'package:airvitals/shared/domain/failures/sensor_failures.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SensorDataRepository)
class SensorDataRepositoryImpl implements SensorDataRepository {
  const SensorDataRepositoryImpl(this._dataSource);

  final SensorDataRemoteDataSource _dataSource;

  @override
  TaskEither<SensorFailure, Stream<SensorData>> getSensorDataStream(
    String uid,
  ) {
    return TaskEither.tryCatch(
      () async =>
          _dataSource.getSensorDataStream(uid).map((model) => model.toDomain()),
      (error, stackTrace) {
        if (error is FirebaseException) {
          return const ConnectionFailure();
        }
        return const ServerFailure();
      },
    );
  }
}
