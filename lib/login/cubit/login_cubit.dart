import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';

import '../../config.dart';

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

  void passwordVisibilityChanged() {
    final password_visibility = !state.password_visibility;
    emit(
      state.copyWith(
        password_visibility: password_visibility
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    if (state.status != LoginStatus.isValidated) return;
    emit(state.copyWith(status: LoginStatus.submissionInProgress));
    print(md5.convert(utf8.encode('${Config.SALT}${state.password}${Config.PEPPER}')).toString());
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        email: state.email,
        password: md5.convert(utf8.encode('${Config.SALT}${state.password}${Config.PEPPER}')).toString(),
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
