import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../app/injection_container.dart';
import '../../../../../common/styles/app_colors.dart';
import '../../../../../common/styles/app_text_styles.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_text_field.dart';
import '../../../../../common/widgets/social_button.dart';
import '../../../../../utils/app_assets.dart';
import '../../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authController = sl<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Hình minh hoạ đầu trang
            Expanded(
              flex: 35,
              child: Center(
                child: SvgPicture.asset(AppAssets.illWelcome),
              ),
            ),

            // Form nhập liệu
            Expanded(
              flex: 65,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),

                      // Tiêu đề form
                      Text('Welcome Back', style: AppTextStyles.heading),
                      const SizedBox(height: 8),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing\nelit, sed do eiusmod tempor.',
                        style: AppTextStyles.subHeading,
                      ),
                      const SizedBox(height: 24),

                      // Ô nhập email
                      CustomTextField(
                        label: 'Email',
                        hintText: 'brandone@example.com',
                        controller: _authController.loginEmailController,
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
                      const SizedBox(height: 18),

                      // Ô nhập mật khẩu
                      CustomTextField(
                        label: 'Password',
                        hintText: '••••••••••',
                        isPassword: true,
                        controller: _authController.loginPasswordController,
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
                      const SizedBox(height: 12),

                      // Ghi nhớ đăng nhập + Quên mật khẩu
                      ValueListenableBuilder<bool>(
                        valueListenable: _authController.loginRememberMe,
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
                                      _authController.loginRememberMe.value = v!,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text('Remember me', style: AppTextStyles.subHeading),
                              const Spacer(),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, '/forgot-password'),
                                child: Text('Forgot Password?',
                                    style: AppTextStyles.link),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 24),

                      // Nút đăng nhập hoặc trạng thái Loading
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
                            label: 'LOGIN',
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final success = await _authController.handleLogin();
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
                                          _authController.errorMessage.value ?? 'Lỗi đăng nhập',
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
                      const SizedBox(height: 14),

                      // Đăng nhập bằng Google
                      SocialButton(
                        label: 'SIGN IN WITH GOOGLE',
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
                      const SizedBox(height: 20),

                      // Link chuyển sang trang Đăng ký
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: AppTextStyles.linkNormal,
                            children: [
                              const TextSpan(
                                  text: "You don't have an account yet? "),
                              WidgetSpan(
                                child: GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                      context, '/signup'),
                                  child: Text('Sign up',
                                      style: AppTextStyles.link),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
