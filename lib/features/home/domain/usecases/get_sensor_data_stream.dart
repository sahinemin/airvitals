import 'package:airvitals/features/home/domain/entities/sensor_data.dart';
import 'package:airvitals/features/home/domain/repositories/sensor_data_repository.dart';
import 'package:airvitals/shared/domain/failures/sensor_failures.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSensorDataStream {
  const GetSensorDataStream(this._repository);

  final SensorDataRepository _repository;

  TaskEither<SensorFailure, Stream<SensorData>> call(String uid) =>
      _repository.getSensorDataStream(uid);
}
