import 'package:flutter/material.dart';
import '../../../../../app/injection_container.dart';
import '../../../../../common/styles/app_colors.dart';
import '../../../../../common/styles/app_text_styles.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_text_field.dart';
import '../../../../../common/widgets/social_button.dart';
import '../../../../../utils/app_assets.dart';
import '../../controllers/auth_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authController = sl<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),

                // Tiêu đề form
                Text('Create an Account', style: AppTextStyles.heading),
                const SizedBox(height: 8),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit,\nsed do eiusmod tempor.',
                  style: AppTextStyles.subHeading,
                ),
                const SizedBox(height: 28),

                // Ô nhập họ tên
                CustomTextField(
                  label: 'Full Name',
                  hintText: 'Brandon Jack',
                  controller: _authController.signupNameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập Họ tên';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Ô nhập email
                CustomTextField(
                  label: 'Email',
                  hintText: 'brandone@example.com',
                  controller: _authController.signupEmailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập Email';
                    }
                    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegExp.hasMatch(value.trim())) {
                      return 'Định dạng Email không hợp lệ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Ô nhập mật khẩu
                CustomTextField(
                  label: 'Password',
                  hintText: '••••••••••',
                  isPassword: true,
                  controller: _authController.signupPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }
                    if (value.length < 6) {
                      return 'Mật khẩu phải dài ít nhất 6 ký tự';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                // Ghi nhớ đăng nhập + Quên mật khẩu
                ValueListenableBuilder<bool>(
                  valueListenable: _authController.signupRememberMe,
                  builder: (context, rememberMe, _) {
                    return Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                            value: rememberMe,
                            activeColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            onChanged: (v) =>
                                _authController.signupRememberMe.value = v!,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('Remember me', style: AppTextStyles.subHeading),
                        const Spacer(),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, '/forgot-password'),
                          child: Text('Forgot Password?', style: AppTextStyles.link),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 28),

                // Nút đăng ký hoặc trạng thái Loading
                ValueListenableBuilder<bool>(
                  valueListenable: _authController.isLoading,
                  builder: (context, isLoading, _) {
                    if (isLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                          ),
                        ),
                      );
                    }
                    return PrimaryButton(
                      label: 'SIGN UP',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final success = await _authController.handleSignUp();
                          if (success) {
                            _authController.clearFields();
                            if (context.mounted) {
                              Navigator.pushReplacementNamed(context, '/successfully');
                            }
                          } else {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    _authController.errorMessage.value ?? 'Lỗi đăng ký',
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Đăng ký bằng Google
                SocialButton(
                  label: 'SIGN UP WITH GOOGLE',
                  iconAsset: AppAssets.icGoogle,
                  useGoogleIcon: true,
                  onPressed: () async {
                    final success = await _authController.handleGoogleLogin();
                    if (success) {
                      _authController.clearFields();
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(context, '/successfully');
                      }
                    } else {
                      if (context.mounted && _authController.errorMessage.value != 'Đăng nhập Google bị hủy.') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _authController.errorMessage.value ?? 'Lỗi đăng nhập Google',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                ),
                const SizedBox(height: 24),

                // Link chuyển sang trang Đăng nhập
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: AppTextStyles.linkNormal,
                      children: [
                        const TextSpan(
                            text: "You don't have an account? "),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text('Sign in', style: AppTextStyles.link),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
