import 'package:airvitals/features/sign_in/domain/usecases/sign_in.dart';
import 'package:airvitals/features/sign_in/presentation/bloc/sign_in_event.dart';
import 'package:airvitals/features/sign_in/presentation/bloc/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(this._signIn) : super(const SignInInitial()) {
    on<SignInSubmitted>(_onSignInSubmitted);
  }

  final SignIn _signIn;

  Future<void> _onSignInSubmitted(
    SignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    emit(const SignInLoading());

    final result = await _signIn(
      email: event.email,
      password: event.password,
    ).run();

    result.match(
      (failure) => emit(SignInFailure(failure)),
      (_) => emit(const SignInSuccess()),
    );
  }
}
