import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../common/styles/app_colors.dart';
import '../../common/styles/app_text_styles.dart';
import '../../common/widgets/custom_button.dart';
import '../../common/widgets/custom_text_field.dart';
import '../../common/widgets/social_button.dart';
import '../../utils/app_assets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ─── Hình minh hoạ — chiếm 35% trên màn hình
            Expanded(
              flex: 35,
              child: Center(
                child: SvgPicture.asset(AppAssets.illWelcome),
              ),
            ),

            // ─── Phần form — có thể cuộn khi bàn phím bật lên
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

                      // ─── Tiêu đề
                      Text('Welcome Back', style: AppTextStyles.heading),
                      const SizedBox(height: 8),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing\nelit, sed do eiusmod tempor.',
                        style: AppTextStyles.subHeading,
                      ),
                      const SizedBox(height: 24),

                      // ─── Ô nhập email
                      CustomTextField(
                        label: 'Email',
                        hintText: 'brandone@example.com',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 18),

                      // ─── Ô nhập mật khẩu
                      CustomTextField(
                        label: 'Password',
                        hintText: '••••••••••',
                        isPassword: true,
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 12),

                      // ─── Ghi nhớ đăng nhập + Quên mật khẩu
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              value: _rememberMe,
                              activeColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              onChanged: (v) =>
                                  setState(() => _rememberMe = v!),
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
                      ),
                      const SizedBox(height: 24),

                      // ─── Nút đăng nhập
                      PrimaryButton(
                        label: 'LOGIN',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // TODO: xử lý logic đăng nhập
                          }
                        },
                      ),
                      const SizedBox(height: 14),

                      // ─── Đăng nhập bằng Google
                      SocialButton(
                        label: 'SIGN IN WITH GOOGLE',
                        iconAsset: AppAssets.icGoogle,
                        useGoogleIcon: true,
                        onPressed: () {},
                      ),
                      const SizedBox(height: 20),

                      // ─── Chưa có tài khoản? Sang màn đăng ký
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
