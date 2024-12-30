import 'package:airvitals/features/sign_up/domain/usecases/sign_up.dart';
import 'package:airvitals/features/sign_up/presentation/bloc/sign_up_event.dart';
import 'package:airvitals/features/sign_up/presentation/bloc/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this._signUp) : super(const SignUpInitial()) {
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  final SignUp _signUp;

  Future<void> _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    emit(const SignUpLoading());

    final result = await _signUp(
      email: event.email,
      password: event.password,
    ).run();

    result.match(
      (failure) => emit(SignUpFailure(failure)),
      (_) => emit(const SignUpSuccess()),
    );
  }
}
