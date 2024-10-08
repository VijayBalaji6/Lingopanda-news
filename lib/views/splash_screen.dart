import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lingoganda_news/constants/app_colors.dart';
import 'package:lingoganda_news/utils/routes/app_route_names.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () async {
      context.goNamed(AppRouteNames.loginInScreen);
    });

    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: Center(
        child: SizedBox(
          height: 200.sp,
          width: 200.sp,
          //child: Image.asset("assets/app_logo/todo_app_logo.png")
        ),
      ),
    );
  }
}
