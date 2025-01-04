part of 'sensor_data_bloc.dart';

sealed class SensorDataState extends Equatable {
  const SensorDataState();

  @override
  List<Object?> get props => [];
}

final class SensorDataInitial extends SensorDataState {
  const SensorDataInitial();
}

final class SensorDataLoading extends SensorDataState {
  const SensorDataLoading();
}

final class SensorDataSuccess extends SensorDataState {
  const SensorDataSuccess(this.data);

  final SensorData data;

  @override
  List<Object?> get props => [data];
}

final class SensorDataFailure extends SensorDataState {
  const SensorDataFailure(this.failure);

  final SensorFailure failure;

  @override
  List<Object?> get props => [failure];
}
