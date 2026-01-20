import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/error/failures.dart';
import 'package:todo/core/usecases/usecases.dart';
import 'package:todo/features/auth/domain/usecases/check_auth_usercase.dart';
import 'package:todo/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:todo/features/auth/domain/usecases/login_usecases.dart';
import 'package:todo/features/auth/domain/usecases/logout_usecases.dart';
import 'package:todo/features/auth/presentations/bloc/auth_event.dart';
import 'package:todo/features/auth/presentations/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCases loginUseCases;
  final LogoutUseCases logoutUseCases;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final CheckAuthUserCase checkAuthUserCase;

  AuthBloc({
    required this.loginUseCases,
    required this.logoutUseCases,
    required this.getCurrentUserUseCase,
    required this.checkAuthUserCase,
  }) : super(AuthInitialState()) {
    on<AuthCheckEvent>(_onAuthCheckEvent);
    on<AuthLoginEvent>(_onAuthLoginEvent);
    on<AuthLogoutEvent>(_onAuthLogoutEvent);
  }
  Future _onAuthCheckEvent(
    AuthCheckEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());

    final result = await checkAuthUserCase(NoParams());

    await result.fold(
      (left) {
        emit(AuthUnAuthenticatedState());
      },
      (right) async {
        if (right) {
          final userResult = await getCurrentUserUseCase(NoParams());
          await userResult.fold(
            (l) {
              emit(AuthUnAuthenticatedState());
            },
            (r) {
              if (r != null) {
                emit(AuthAuthenticatedState(userEntity: r));
              } else {
                emit(AuthUnAuthenticatedState());
              }
            },
          );
        }
      },
    );
  }

  Future _onAuthLoginEvent(
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());

    final result = await loginUseCases(
      LoginParams(email: event.email, password: event.password),
    );

    result.fold((left) {
      String message ="Auth Error";
          if(left is InvalidCredentialFailure){
            message="Wrong EMAIL or PASSWORD";
          }
          else if(left is ServerFailure){
            message= "Server failure";
          }
          else{
            emit(AuthErrorState(message: message));
          }
    }, (right) {
      emit(AuthAuthenticatedState(userEntity: right));
    });
  }

  Future _onAuthLogoutEvent(
      AuthLogoutEvent event,
      Emitter<AuthState> emit,
      )async{
    emit(AuthLoadingState());

    final result = await logoutUseCases(NoParams());

    result.fold((l){
      emit(AuthErrorState(message: "LogOut Error"));
    },(r){
      emit(AuthUnAuthenticatedState());
    });


  }
}
