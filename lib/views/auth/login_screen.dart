import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_26/views/auth/controller/login_controller.dart';

import '../../core/spacing/app_spacing.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  /// it is the dependency injection that i inject
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Login', style: TextStyle(fontSize: 26.sp)),
              SizedBox(height: 20.h),

              /// Form section
              _formSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formSection() {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: controller.nameController,
            decoration: InputDecoration(
              hintText: 'Enter your name',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter you name';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
          ),

          SizedBox(height: AppSpacing.medium.h),

          /// obx is use to identify that this widget should be rebuild similar to consumer in riverpod/provider
          Obx(() {
            return TextFormField(
              controller: controller.passwordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter you password';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Enter your password',
                prefixIcon: Icon(Icons.fingerprint),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.isPasswordShow.value =
                        !controller.isPasswordShow.value;
                  },
                  icon: controller.isPasswordShow.value
                      ? Icon(Icons.remove_red_eye_outlined)
                      : Icon(Icons.visibility_off_outlined),
                ),
              ),
              keyboardType: TextInputType.text,
              obscureText: controller.isPasswordShow.value,
            );
          }),

          SizedBox(height: AppSpacing.medium.h),

          /// obx is use to identify that this widget should be rebuild similar to consumer in riverpod/provider
          Obx(() {
            return ElevatedButton(
              onPressed: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.login();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
              ),
              child: Center(
                child: controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
