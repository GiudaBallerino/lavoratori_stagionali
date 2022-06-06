part of 'login_cubit.dart';

enum LoginStatus{
  invalid,
  isValidated,
  submissionInProgress,
  submissionSuccess,
  isSubmissionFailure,
}

class LoginState extends Equatable {
  const LoginState({
    this.email = '',
    this.password = '',
    this.password_visibility = false,
    this.status = LoginStatus.invalid,
    this.errorMessage,
  });

  final String email;
  final String password;
  final bool password_visibility;
  final String? errorMessage;
  final LoginStatus status;
  @override
  List<Object> get props => [email, password, password_visibility, status];

  LoginState copyWith({
    String? email,
    String? password,
    bool? password_visibility,
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      password_visibility: password_visibility ?? this.password_visibility,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}