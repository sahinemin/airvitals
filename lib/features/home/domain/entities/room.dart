import 'package:freezed_annotation/freezed_annotation.dart';

part 'room.freezed.dart';

@freezed
class Room with _$Room {
  const factory Room({
    required String id,
    required String name,
    required double temperature,
    required double humidity,
  }) = _Room;
}
