import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task_26/core/navigation/app_route.dart';
import 'package:task_26/service/auth_service.dart';

class LoginController extends GetxController {
  final AuthService _authService = AuthService();

  /// to check that is user filled formed that data we required for login
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController(
    text: 'johnd',
  );
  final TextEditingController passwordController = TextEditingController(
    text: 'm38rmF\$',
  );

  RxBool isPasswordShow = RxBool(true);
  RxBool isLoading = RxBool(false);

  /// for the testing purpose using valid data from fake store api
  /// name -> johnd and password -> m38rmF$
  ///
  Future<void> login() async {
    isLoading.value = true;

    final response = await _authService.login(
      nameController.text.toString(),
      passwordController.text.toString(),
    );

    if (response == true) {
      isLoading.value = false;
      Get.toNamed(AppRoute.home);
    } else {
      isLoading.value = false;
      Get.snackbar('Something went wrong', 'Please check the credential Again');
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
