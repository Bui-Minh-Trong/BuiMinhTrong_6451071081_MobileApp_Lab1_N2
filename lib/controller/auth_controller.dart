import 'package:flutter/material.dart';

/// Quản lý trạng thái UI cho các màn hình auth — chỉ UI, chưa kết nối backend.
class AuthController {
  // ─── Màn hình Đăng nhập ───────────────────────────────
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final ValueNotifier<bool> loginRememberMe = ValueNotifier(false);

  // ─── Màn hình Đăng ký ─────────────────────────────────
  final signupNameController = TextEditingController();
  final signupEmailController = TextEditingController();
  final signupPasswordController = TextEditingController();
  final ValueNotifier<bool> signupRememberMe = ValueNotifier(false);

  // ─── Màn hình Quên mật khẩu ───────────────────────────
  final forgotEmailController = TextEditingController();

  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    loginRememberMe.dispose();
    signupNameController.dispose();
    signupEmailController.dispose();
    signupPasswordController.dispose();
    signupRememberMe.dispose();
    forgotEmailController.dispose();
  }
}

