part of 'rooms_bloc.dart';

sealed class RoomsEvent {
  const RoomsEvent();
}

final class RoomsStarted extends RoomsEvent {
  const RoomsStarted(this.uid);

  final String uid;
}

final class RoomAdded extends RoomsEvent {
  const RoomAdded(this.name);

  final String name;
}
