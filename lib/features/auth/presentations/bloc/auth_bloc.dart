import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/error/failures.dart';
import 'package:todo/core/usecases/usecases.dart';
import 'package:todo/features/auth/domain/usecases/check_auth_usercase.dart';
import 'package:todo/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:todo/features/auth/domain/usecases/login_usecases.dart';
import 'package:todo/features/auth/domain/usecases/logout_usecases.dart';
import 'package:todo/features/auth/domain/usecases/register_usecase.dart';
import 'package:todo/features/auth/presentations/bloc/auth_event.dart';
import 'package:todo/features/auth/presentations/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCases loginUseCases;
  final LogoutUseCases logoutUseCases;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final CheckAuthUserCase checkAuthUserCase;
  final RegisterUseCase registerUseCase;

  AuthBloc({
    required this.loginUseCases,
    required this.logoutUseCases,
    required this.getCurrentUserUseCase,
    required this.checkAuthUserCase,
    required this.registerUseCase,
  }) : super(AuthInitialState()) {
    on<AuthCheckEvent>(_onAuthCheckEvent);
    on<AuthLoginEvent>(_onAuthLoginEvent);
    on<AuthLogoutEvent>(_onAuthLogoutEvent);
    on<AuthSignUpEvent>(_onAuthSignUpEvent);
  }

  // =====================================================================
  // AUTH CHECK: Fixed version
  // =====================================================================
  Future<void> _onAuthCheckEvent(
      AuthCheckEvent event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoadingState());

    // ✅ Get the auth check result
    final result = await checkAuthUserCase(NoParams());

    // ✅ Use a single fold with all logic inside
    await result.fold(
      // LEFT: Not authenticated
          (failure) async {
        emit(AuthUnAuthenticatedState());
      },
      // RIGHT: Check if authenticated
          (isAuthenticated) async {
        if (isAuthenticated) {
          // Get user data
          final userResult = await getCurrentUserUseCase(NoParams());

          userResult.fold(
                (failure) {
              emit(AuthUnAuthenticatedState());
            },
                (user) {
              if (user != null) {
                emit(AuthAuthenticatedState(userEntity: user));
              } else {
                emit(AuthUnAuthenticatedState());
              }
            },
          );
        } else {
          emit(AuthUnAuthenticatedState());
        }
      },
    );
  }

  // =====================================================================
  // LOGIN: This one is fine
  // =====================================================================
  Future<void> _onAuthLoginEvent(
      AuthLoginEvent event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoadingState());

    final result = await loginUseCases(
      LoginParams(email: event.email, password: event.password),
    );

    result.fold(
          (failure) {
        String message = "Auth Error";

        if (failure is InvalidCredentialFailure) {
          message = "Wrong EMAIL or PASSWORD";
        } else if (failure is ServerFailure) {
          message = "Server failure. Please try again.";
        }

        emit(AuthErrorState(message: message));
      },
          (user) {
        emit(AuthAuthenticatedState(userEntity: user));
      },
    );
  }

  // =====================================================================
  // LOGOUT: This one is fine
  // =====================================================================
  Future<void> _onAuthLogoutEvent(
      AuthLogoutEvent event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoadingState());

    final result = await logoutUseCases(NoParams());

    result.fold(
          (failure) {
        emit(AuthErrorState(message: "Logout Error. Please try again."));
      },
          (success) {
        emit(AuthUnAuthenticatedState());
      },
    );
  }

  // =====================================================================
  // SIGN UP: This one is fine
  // =====================================================================
  Future<void> _onAuthSignUpEvent(
      AuthSignUpEvent event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoadingState());

    final result = await registerUseCase(
      RegisterParams(
        email: event.email,
        password: event.password,
        username: event.userName,
      ),
    );

    result.fold(
          (failure) {
        String message = "Registration Error";

        if (failure is InvalidCredentialFailure) {
          message = "Invalid EMAIL or PASSWORD format";
        } else if (failure is ServerFailure) {
          message = "Server failure. Please try again.";
        }

        emit(AuthErrorState(message: message));
      },
          (user) {
        emit(AuthAuthenticatedState(userEntity: user));
      },
    );
  }
}