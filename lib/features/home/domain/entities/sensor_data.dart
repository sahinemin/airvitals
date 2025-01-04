import 'package:freezed_annotation/freezed_annotation.dart';

part 'sensor_data.freezed.dart';

@freezed
class SensorData with _$SensorData {
  const factory SensorData({
    required double temperature,
    required double humidity,
  }) = _SensorData;
}
