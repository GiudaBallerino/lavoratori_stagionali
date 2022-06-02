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
    this.status = LoginStatus.invalid,
    this.errorMessage,
  });

  final String email;
  final String password;
  final String? errorMessage;
  final LoginStatus status;
  @override
  List<Object> get props => [email, password, status];

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}