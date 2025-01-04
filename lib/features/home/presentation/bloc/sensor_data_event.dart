part of 'sensor_data_bloc.dart';
sealed class SensorDataEvent {
  const SensorDataEvent();
}

final class SensorDataStarted extends SensorDataEvent {
  const SensorDataStarted(this.uid);

  final String uid;
}

final class SensorDataReceived extends SensorDataEvent {
  const SensorDataReceived(this.data);

  final SensorData data;
}

final class SensorDataErrored extends SensorDataEvent {
  const SensorDataErrored(this.failure);

  final SensorFailure failure;
}
