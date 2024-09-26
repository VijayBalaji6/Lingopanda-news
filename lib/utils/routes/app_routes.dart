import 'package:go_router/go_router.dart';
import 'package:lingoganda_news/utils/routes/app_route_names.dart';
import 'package:lingoganda_news/views/auth/login_screen.dart';
import 'package:lingoganda_news/views/auth/sign_up_screen.dart';
import 'package:lingoganda_news/views/home/home_screen.dart';
import 'package:lingoganda_news/views/splash_screen.dart';
import 'package:lingoganda_news/widgets/error_route_page.dart';

class AppRoutes {
  static final GoRouter appRoutes = GoRouter(
    initialLocation: '/splash',
    errorBuilder: (context, state) => ErrorRouteScreen(
      errorState: state,
    ),
    routes: [
      GoRoute(
        name: AppRouteNames.splashScreen,
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: AppRouteNames.loginInScreen,
        path: '/login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        name: AppRouteNames.signUpScreen,
        path: '/signUp',
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        name: AppRouteNames.homeScreen,
        path: '/home',
        builder: (context, state) => HomeScreen(),
      ),
    ],
  );
}
