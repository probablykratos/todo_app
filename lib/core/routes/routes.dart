import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/features/auth/presentations/bloc/auth_state.dart';
import 'package:todo/features/auth/presentations/view/login.dart';
import 'package:todo/features/auth/presentations/view/register.dart';
import 'package:todo/features/splash/view/splash_view.dart';
import 'package:todo/features/splash/view/homepage.dart';
import '../../features/auth/presentations/bloc/auth_bloc.dart';

class AppRouter {
  final AuthBloc authBloc;
  DateTime? _splashStartTime;
  bool _canLeaveSplash = false;

  AppRouter({required this.authBloc}) {
    _splashStartTime = DateTime.now();
    _startSplashTimer();
  }

  void _startSplashTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      _canLeaveSplash = true;
    });
  }

  GoRouter get router => GoRouter(
    initialLocation: '/splash',
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final authState = authBloc.state;
      final currentLocation = state.matchedLocation;
      final hasInitialized = authState is! AuthInitialState;

      // Force splash screen to show for at least 2 seconds
      if (currentLocation == '/splash' && !_canLeaveSplash) {
        return null;
      }

      // Stay on splash screen until initialization is complete
      if (!hasInitialized) {
        return currentLocation == '/splash' ? null : '/splash';
      }

      if (authState is AuthLoadingState) {
        return currentLocation == '/splash' ? null : null;
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
      GoRoute(path: '/register', builder: (context, state) => const RegisterView()),
      GoRoute(path: '/home', builder: (context, state) => const HomeView()),
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