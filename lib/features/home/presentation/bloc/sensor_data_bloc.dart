import 'dart:async';

import 'package:airvitals/features/home/domain/entities/sensor_data.dart';
import 'package:airvitals/features/home/domain/usecases/get_sensor_data_stream.dart';
import 'package:airvitals/shared/domain/failures/sensor_failures.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'sensor_data_event.dart';
part 'sensor_data_state.dart';

@injectable
class SensorDataBloc extends Bloc<SensorDataEvent, SensorDataState> {
  SensorDataBloc(this._getSensorDataStream) : super(const SensorDataInitial()) {
    on<SensorDataStarted>(_onStarted);
    on<SensorDataReceived>(_onReceived);
    on<SensorDataErrored>(_onErrored);
  }

  final GetSensorDataStream _getSensorDataStream;

  Future<void> _onStarted(
    SensorDataStarted event,
    Emitter<SensorDataState> emit,
  ) async {
    emit(const SensorDataLoading());

    final result = await _getSensorDataStream(event.uid).run();

    await result.match(
      (failure) async => emit(SensorDataFailure(failure)),
      (stream) async {
        await emit.onEach<SensorData>(
          stream,
          onData: (data) => emit(SensorDataSuccess(data)),
          onError: (error, stackTrace) => emit(
            const SensorDataFailure(ServerFailure()),
          ),
        );
      },
    );
  }

  void _onReceived(SensorDataReceived event, Emitter<SensorDataState> emit) {
    emit(SensorDataSuccess(event.data));
  }

  void _onErrored(SensorDataErrored event, Emitter<SensorDataState> emit) {
    emit(SensorDataFailure(event.failure));
  }
}
