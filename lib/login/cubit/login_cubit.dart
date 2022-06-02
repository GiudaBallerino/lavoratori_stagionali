import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = value;
    emit(
      state.copyWith(
        email: email,
        status: state.password != '' && email != ''
            ? LoginStatus.isValidated
            : LoginStatus.invalid,
      ),
    );
  }

  void passwordChanged(String value) {
    final password = value;
    emit(
      state.copyWith(
        password: password,
        status: password != '' && state.email != ''
            ? LoginStatus.isValidated
            : LoginStatus.invalid,
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    if (state.status != LoginStatus.isValidated) return;
    emit(state.copyWith(status: LoginStatus.submissionInProgress));
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: LoginStatus.submissionSuccess));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: LoginStatus.isSubmissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.isSubmissionFailure));
    }
  }
}
