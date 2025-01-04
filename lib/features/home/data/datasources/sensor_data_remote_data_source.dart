import 'package:airvitals/features/home/data/models/sensor_data_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

abstract interface class SensorDataRemoteDataSource {
  Stream<SensorDataModel> getSensorDataStream(String uid);
}

@Injectable(as: SensorDataRemoteDataSource)
class FirebaseSensorDataRemoteDataSource implements SensorDataRemoteDataSource {
  const FirebaseSensorDataRemoteDataSource(this._database);

  final FirebaseDatabase _database;

  @override
  Stream<SensorDataModel> getSensorDataStream(String uid) {
    final ref = _database.ref('$uid/data');
    return ref.onValue.map((event) {
      if (event.snapshot.value == null) {
        return const SensorDataModel(
          temperature: 0,
          humidity: 0,
        );
      }

      final value = event.snapshot.value! as Map<Object?, Object?>;
      final data = Map<String, dynamic>.from(
        value.map((key, value) => MapEntry(key.toString(), value)),
      );

      return SensorDataModel.fromJson(data);
    });
  }
}
