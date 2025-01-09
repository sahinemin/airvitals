import 'dart:async';

import 'package:airvitals/features/home/domain/entities/room.dart';
import 'package:airvitals/features/home/domain/usecases/add_room.dart';
import 'package:airvitals/features/home/domain/usecases/get_rooms_stream.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'rooms_event.dart';
part 'rooms_state.dart';

@injectable
class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  RoomsBloc(
    this._getRoomsStream,
    this._addRoom,
    this._auth,
  ) : super(const RoomsInitial()) {
    on<RoomsStarted>(_onStarted);
    on<RoomAdded>(_onRoomAdded);
  }

  final GetRoomsStream _getRoomsStream;
  final AddRoom _addRoom;
  final FirebaseAuth _auth;

  Future<void> _onStarted(
    RoomsStarted event,
    Emitter<RoomsState> emit,
  ) async {
    emit(const RoomsLoading());

    final result = await _getRoomsStream(event.uid).run();

    await result.match(
      (failure) async => emit(const RoomsFailure()),
      (stream) async {
        await emit.onEach<List<Room>>(
          stream,
          onData: (rooms) => emit(RoomsSuccess(rooms)),
          onError: (error, stackTrace) => emit(const RoomsFailure()),
        );
      },
    );
  }

  Future<void> _onRoomAdded(
    RoomAdded event,
    Emitter<RoomsState> emit,
  ) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    await _addRoom(uid: uid, name: event.name).run();
  }
}
