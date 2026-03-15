import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/validators.dart';
import '../../model/login_request.dart';
import '../../repository/LoginRepository.dart';
import 'login_event.dart';
import 'login_state.dart';



class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;

  LoginBloc({required this.repository}) : super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<LoginSubmitted>(_onLoginSubmitted);
  }


  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    final emailValidation = Validators.validateEmail(event.email);

    emit(
      state.copyWith(
        email: event.email,
        emailError: emailValidation,
        clearEmailError: emailValidation == null,
        clearErrorMessage: true,
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        password: event.password,
        passwordError: Validators.validatePassword(event.password),
        clearErrorMessage: true,
      ),
    );
  }

  void _onTogglePasswordVisibility(
      TogglePasswordVisibility event,
      Emitter<LoginState> emit,
      ) {
    emit(
      state.copyWith(
        isPasswordHidden: !state.isPasswordHidden,
      ),
    );
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event,
      Emitter<LoginState> emit,
      ) async {
    final emailError = Validators.validateEmail(state.email);
    final passwordError = Validators.validatePassword(state.password);

    if (emailError != null || passwordError != null) {
      emit(
        state.copyWith(
          emailError: emailError,
          passwordError: passwordError,
          isLoading: false,
          isSuccess: false,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isLoading: true,
        isSuccess: false,
        clearErrorMessage: true,
      ),
    );

    try {
      final request = LoginRequest(
        email: state.email.trim(),
        password: state.password.trim(),
      );

      final result = await repository.login(request);

      if (result) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            clearErrorMessage: true,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }
}