
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/app_image_url.dart';
import 'package:todo/features/auth/presentations/bloc/auth_bloc.dart';
import 'package:todo/features/auth/presentations/bloc/auth_event.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds:2), () {
      if (mounted) {
        context.read<AuthBloc>().add(AuthCheckEvent());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AppImageUrl.logo,width: 80,height: 80,),
      ),
    );
  }
}
