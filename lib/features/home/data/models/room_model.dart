import 'package:airvitals/features/home/domain/entities/room.dart';
import 'package:json_annotation/json_annotation.dart';

part 'room_model.g.dart';

@JsonSerializable()
class RoomModel {
  const RoomModel({
    required this.id,
    required this.name,
    required this.temperature,
    required this.humidity,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);

  final String id;
  final String name;
  final double temperature;
  final double humidity;

  Map<String, dynamic> toJson() => _$RoomModelToJson(this);

  Room toDomain() => Room(
        id: id,
        name: name,
        temperature: temperature,
        humidity: humidity,
      );
}
