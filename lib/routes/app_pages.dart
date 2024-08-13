import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:task1/Middleware/auth_middleware.dart';
import 'package:task1/view/auth/create_account/create_account_view.dart';
import 'package:task1/view/home/home_view.dart';
import 'package:task1/view/nick_name/nick_name_view.dart';
import 'package:task1/view/on_boarding/on_boarding_view.dart';

import '../Middleware/on_boarding_middleware.dart';
import '../view/auth/login_view/login_view.dart';
import '../view/splash_screen.dart';
import 'app_routes.dart';

class AppPages{
  AppPages._();
  static get INITIAL => Routes.SPLASHSCREEN;

  static final routes = [
    GetPage(
      name: Paths.SPLASHSCREEN,
      page: () => const SplashScreen(),

    ),
    GetPage(
      name: Paths.ONBOARDING,
      page: () => const OnBoardingView(),
      middlewares: [OnBoardingMiddleware()],
    ), GetPage(
      name: Paths.LOGIN,
      page: () =>  LoginView(),
      middlewares: [AuthMiddleware()],
    ), GetPage(
      name: Paths.NICKNAME,
      page: () =>  NickNameView(),
      middlewares: [],
    ), GetPage(
      name: Paths.HOME,
      page: () =>  HomeView(),
      middlewares: [],
    ),GetPage(
      name: Paths.CREATEACCOUNT,
      page: () =>  CreateAccountView(),
      middlewares: [],
    ),
  ];
}