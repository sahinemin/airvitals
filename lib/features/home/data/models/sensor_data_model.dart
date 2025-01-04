import 'package:airvitals/features/home/domain/entities/sensor_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sensor_data_model.g.dart';

@JsonSerializable()
class SensorDataModel {
  const SensorDataModel({
    required this.temperature,
    required this.humidity,
  });

  factory SensorDataModel.fromJson(Map<String, dynamic> json) =>
      _$SensorDataModelFromJson(json);

  final double temperature;
  final double humidity;

  Map<String, dynamic> toJson() => _$SensorDataModelToJson(this);

  SensorData toDomain() => SensorData(
        temperature: temperature,
        humidity: humidity,
      );
}
