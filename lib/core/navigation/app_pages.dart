import 'package:get/get.dart';
import 'package:task_26/core/navigation/app_route.dart';
import 'package:task_26/views/auth/login_screen.dart';
import 'package:task_26/views/home/home_screen.dart';
import 'package:task_26/views/profile/profile_screen.dart';

/// our app page is defined here that which page should show which page
class AppPages {
  static final pages = [
    GetPage(
      name: AppRoute.login,
      page: () => LoginScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(name: AppRoute.home, page: () => HomeScreen()),
    GetPage(name: AppRoute.profile, page: () => ProfileScreen()),
  ];
}
