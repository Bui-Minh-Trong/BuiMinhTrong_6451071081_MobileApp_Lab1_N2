import 'package:flutter/material.dart';
import '../../domain/usecases/login_use_case.dart';
import '../../domain/usecases/signup_use_case.dart';
import '../../domain/usecases/login_with_google_use_case.dart';

class AuthController {
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  final LoginWithGoogleUseCase loginWithGoogleUseCase;

  AuthController({
    required this.loginUseCase,
    required this.signUpUseCase,
    required this.loginWithGoogleUseCase,
  });

  // Trạng thái loading và thông báo lỗi cho UI
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier(null);

  // Bộ điều khiển nhập liệu cho các Form
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final ValueNotifier<bool> loginRememberMe = ValueNotifier(false);

  final signupNameController = TextEditingController();
  final signupEmailController = TextEditingController();
  final signupPasswordController = TextEditingController();
  final ValueNotifier<bool> signupRememberMe = ValueNotifier(false);

  final forgotEmailController = TextEditingController();

  Future<bool> handleLogin() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;

      final email = loginEmailController.text.trim();
      final password = loginPasswordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        throw Exception('Vui lòng điền đầy đủ email và mật khẩu.');
      }

      await loginUseCase(email, password);
      return true;
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> handleSignUp() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;

      final name = signupNameController.text.trim();
      final email = signupEmailController.text.trim();
      final password = signupPasswordController.text.trim();

      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        throw Exception('Vui lòng điền đầy đủ thông tin đăng ký.');
      }

      await signUpUseCase(email, password, name);
      return true;
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> handleGoogleLogin() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;
      await loginWithGoogleUseCase();
      return true;
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void clearFields() {
    loginEmailController.clear();
    loginPasswordController.clear();
    signupNameController.clear();
    signupEmailController.clear();
    signupPasswordController.clear();
    forgotEmailController.clear();
    errorMessage.value = null;
  }

  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    loginRememberMe.dispose();
    signupNameController.dispose();
    signupEmailController.dispose();
    signupPasswordController.dispose();
    signupRememberMe.dispose();
    forgotEmailController.dispose();
    isLoading.dispose();
    errorMessage.dispose();
  }
}
