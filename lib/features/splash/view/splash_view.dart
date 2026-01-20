
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/app_image_url.dart';

import '../../../core/routes/route_names.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_)async{
      await Future.delayed(const Duration(seconds: 2));
      context.goNamed(RouteNames.login);
    });
    super.initState();
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
