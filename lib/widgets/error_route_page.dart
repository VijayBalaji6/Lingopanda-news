import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lingoganda_news/constants/app_colors.dart';

class ErrorRouteScreen extends StatelessWidget {
  const ErrorRouteScreen({super.key, required this.errorState});

  final GoRouterState errorState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Image.asset(AppImage.imgAppError,
        //     height: 250, width: 250, fit: BoxFit.cover),
        const SizedBox(height: 8),
        const Text('Page Not Found!',
            style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 32,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ElevatedButton(
            onPressed: () {
              GoRouter.of(context).go('/splash');
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blackColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            child: const Text('Go To Home',
                style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w500))),
        Text('Page Error : ${errorState.error?.message.toString()}'),
      ],
    )));
  }
}
