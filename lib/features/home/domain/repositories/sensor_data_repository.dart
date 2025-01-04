import 'package:airvitals/features/home/domain/entities/sensor_data.dart';
import 'package:airvitals/shared/domain/failures/sensor_failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class SensorDataRepository {
  TaskEither<SensorFailure, Stream<SensorData>> getSensorDataStream(String uid);
}
