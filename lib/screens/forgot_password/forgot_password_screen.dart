import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../common/styles/app_colors.dart';
import '../../common/styles/app_text_styles.dart';
import '../../common/widgets/custom_button.dart';
import '../../common/widgets/custom_text_field.dart';
import '../../utils/app_assets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),

              // ─── Hình minh hoạ ────────────────────────────
              Center(
                child: SvgPicture.asset(
                  AppAssets.illForgotPassword,
                  height: 180,
                ),
              ),
              const SizedBox(height: 32),

              // ─── Tiêu đề ──────────────────────────────────
              Text('Forgot Password?', style: AppTextStyles.heading),
              const SizedBox(height: 12),
              Text(
                'To reset your password, you need your email or mobile number that can be authenticated.',
                style: AppTextStyles.subHeading,
              ),
              const SizedBox(height: 32),

              // ─── Ô nhập email ──────────────────────────────
              CustomTextField(
                label: 'Email',
                hintText: 'brandone@example.com',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 32),

              // ─── Nút gửi yêu cầu đặt lại mật khẩu ────────
              PrimaryButton(
                label: 'RESET PASSWORD',
                onPressed: () =>
                    Navigator.pushNamed(context, '/check-email'),
              ),
              const SizedBox(height: 24),

              // ─── Quay lại màn hình đăng nhập ──────────────
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.popUntil(
                    context,
                    ModalRoute.withName('/login'),
                  ),
                  child: Text('Back to Login', style: AppTextStyles.link),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

