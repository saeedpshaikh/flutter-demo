import 'package:equatable/equatable.dart';

class LoginState extends Equatable  {
  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;
  final bool isPasswordHidden;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const LoginState({
    this.email = '',
    this.password = '',
    this.emailError,
    this.passwordError,
    this.isPasswordHidden = true,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  LoginState copyWith({
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
    bool? isPasswordHidden,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    bool clearEmailError = false,
    bool clearPasswordError = false,
    bool clearErrorMessage = false,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: clearEmailError ? null : (emailError ?? this.emailError),
      passwordError: clearPasswordError ? null : (passwordError ?? this.passwordError),
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    emailError,
    passwordError,
    isPasswordHidden,
    isLoading,
    isSuccess,
    errorMessage,
  ];
}