import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/features/auth/presentations/bloc/auth_state.dart';
import 'package:todo/features/auth/presentations/view/login.dart';
import 'package:todo/features/auth/presentations/view/register.dart';
import 'package:todo/features/splash/view/splash_view.dart';
import 'package:todo/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todo/features/todo/presentation/views/add_todo.dart';
import 'package:todo/features/todo/presentation/views/todo_page.dart';
import '../../features/auth/presentations/bloc/auth_bloc.dart';
import '../../injection_container.dart' as di;

class AppRouter {
  final AuthBloc authBloc;

  AppRouter({required this.authBloc});

  GoRouter get router => GoRouter(
    initialLocation: '/splash',
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final authState = authBloc.state;
      final currentLocation = state.matchedLocation;
      final hasInitialized = authState is! AuthInitialState;

      if (!hasInitialized) {
        return currentLocation == '/splash' ? null : '/splash';
      }

      if (authState is AuthLoadingState) {
        return null;
      }

      if (authState is AuthErrorState) {
        if (currentLocation == '/login' || currentLocation == '/register') {
          return null;
        }
        return '/login';
      }

      if (authState is AuthUnAuthenticatedState) {
        if (currentLocation == '/login' || currentLocation == '/register') {
          return null;
        }
        return '/login';
      }

      if (authState is AuthAuthenticatedState) {
        if (currentLocation == '/login' ||
            currentLocation == '/register' ||
            currentLocation == '/splash') {
          return '/home';
        }
        return null;
      }

      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashView()),
      GoRoute(path: '/login', builder: (context, state) => const LoginView()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterView(),
      ),
      ShellRoute(
        builder: (context,state,child){
          return BlocProvider(create: (_)=>di.sl<TodoBloc>(),child: child,);
        },
        routes: [
          GoRoute(path: '/home',builder: (context,state)=>TodoPageView()),
        ],
      ),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
