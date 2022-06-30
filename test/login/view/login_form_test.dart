import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavoratori_stagionali/login/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
  const loginButtonKey = Key('loginForm_continue_raisedButton');
  const signInWithGoogleButtonKey = Key('loginForm_googleLogin_raisedButton');
  const emailInputKey = Key('loginForm_emailInput_textField');
  const passwordInputKey = Key('loginForm_passwordInput_textField');
  const createAccountButtonKey = Key('loginForm_createAccount_flatButton');

  const testEmail = 'test@gmail.com';
  const testPassword = 'testP@ssw0rd1';

  group('LoginForm', () {
    late LoginCubit loginCubit;

    setUp(() {
      loginCubit = MockLoginCubit();
      when(() => loginCubit.state).thenReturn(const LoginState());
      when(() => loginCubit.logInWithCredentials()).thenAnswer((_) async {});
    });

    group('calls', () {
      testWidgets('emailChanged when email changes', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider.value(
                value: loginCubit,
                child: const LoginForm(),
              ),
            ),
          ),
        );
        await tester.enterText(find.byKey(emailInputKey), testEmail);
        verify(() => loginCubit.emailChanged(testEmail)).called(1);
      });

      testWidgets('passwordChanged when password changes', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider.value(
                value: loginCubit,
                child: const LoginForm(),
              ),
            ),
          ),
        );
        await tester.enterText(find.byKey(passwordInputKey), testPassword);
        verify(() => loginCubit.passwordChanged(testPassword)).called(1);
      });

      testWidgets('logInWithCredentials when login button is pressed',
              (tester) async {
            when(() => loginCubit.state).thenReturn(
              const LoginState(status: LoginStatus.isValidated),
            );
            await tester.pumpWidget(
              MaterialApp(
                home: Scaffold(
                  body: BlocProvider.value(
                    value: loginCubit,
                    child: const LoginForm(),
                  ),
                ),
              ),
            );
            await tester.tap(find.byKey(loginButtonKey));
            verify(() => loginCubit.logInWithCredentials()).called(1);
          });
    });

    group('renders', () {
      testWidgets('AuthenticationFailure SnackBar when submission fails',
              (tester) async {
            whenListen(
              loginCubit,
              Stream.fromIterable(const <LoginState>[
                LoginState(status: LoginStatus.submissionInProgress),
                LoginState(status: LoginStatus.isSubmissionFailure),
              ]),
            );
            await tester.pumpWidget(
              MaterialApp(
                home: Scaffold(
                  body: BlocProvider.value(
                    value: loginCubit,
                    child: const LoginForm(),
                  ),
                ),
              ),
            );
            await tester.pump();
            expect(find.text('Autenticazione fallita'), findsOneWidget);
          });

      testWidgets('disabled login button when status is not validated',
              (tester) async {
            when(() => loginCubit.state).thenReturn(
              const LoginState(status: LoginStatus.invalid),
            );
            await tester.pumpWidget(
              MaterialApp(
                home: Scaffold(
                  body: BlocProvider.value(
                    value: loginCubit,
                    child: const LoginForm(),
                  ),
                ),
              ),
            );
            final loginButton = tester.widget<ElevatedButton>(
              find.byKey(loginButtonKey),
            );
            expect(loginButton.enabled, isFalse);
          });

      testWidgets('enabled login button when status is validated',
              (tester) async {
            when(() => loginCubit.state).thenReturn(
              const LoginState(status: LoginStatus.isValidated),
            );
            await tester.pumpWidget(
              MaterialApp(
                home: Scaffold(
                  body: BlocProvider.value(
                    value: loginCubit,
                    child: const LoginForm(),
                  ),
                ),
              ),
            );
            final loginButton = tester.widget<ElevatedButton>(
              find.byKey(loginButtonKey),
            );
            expect(loginButton.enabled, isTrue);
          });
    });
  });
}