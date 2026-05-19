import 'package:flutter/material.dart';
import '../../common/styles/app_colors.dart';
import '../../common/styles/app_text_styles.dart';
import '../../common/widgets/custom_button.dart';
import '../../common/widgets/custom_text_field.dart';
import '../../common/widgets/social_button.dart';
import '../../utils/app_assets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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

                // ─── Tiêu đề
                Text('Create an Account', style: AppTextStyles.heading),
                const SizedBox(height: 8),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit,\nsed do eiusmod tempor.',
                  style: AppTextStyles.subHeading,
                ),
                const SizedBox(height: 28),

                // ─── Họ tên
                CustomTextField(
                  label: 'Full Name',
                  hintText: 'Brandon Jack',
                  controller: _nameController,
                ),
                const SizedBox(height: 20),

                // ─── Ô nhập email
                CustomTextField(
                  label: 'Email',
                  hintText: 'brandone@example.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),

                // ─── Ô nhập mật khẩu
                CustomTextField(
                  label: 'Password',
                  hintText: '••••••••••',
                  isPassword: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 14),

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
                        onChanged: (v) => setState(() => _rememberMe = v!),
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
                ),
                const SizedBox(height: 28),

                // ─── Nút đăng ký
                PrimaryButton(
                  label: 'SIGN UP',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: xử lý logic đăng ký
                    }
                  },
                ),
                const SizedBox(height: 16),

                // ─── Đăng ký bằng Google
                SocialButton(
                  label: 'SIGN UP WITH GOOGLE',
                  iconAsset: AppAssets.icGoogle,
                  useGoogleIcon: true,
                  onPressed: () {},
                ),
                const SizedBox(height: 24),

                // ─── Đã có tài khoản? Quay lại đăng nhập
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
