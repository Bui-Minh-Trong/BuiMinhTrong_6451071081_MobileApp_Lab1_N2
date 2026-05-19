import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../common/styles/app_colors.dart';
import '../../common/styles/app_text_styles.dart';
import '../../common/widgets/custom_button.dart';
import '../../utils/app_assets.dart';

class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),

              // ─── Hình minh hoạ ──────────────────────────
              Center(
                child: SvgPicture.asset(
                  AppAssets.illCheckEmail,
                  height: 200,
                ),
              ),
              const SizedBox(height: 32),

              // ─── Tiêu đề ────────────────────────────────
              Text('Check Your Email', style: AppTextStyles.heading),
              const SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  style: AppTextStyles.subHeading,
                  children: const [
                    TextSpan(
                        text:
                            'We have sent the reset password to the address '),
                    TextSpan(
                      text: 'brandone@example.com',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),

              // ─── Nút mở ứng dụng email ──────────────────────
              PrimaryButton(
                label: 'OPEN YOUR EMAIL',
                onPressed: () =>
                    Navigator.pushNamed(context, '/successfully'),
              ),
              const SizedBox(height: 16),

              // ─── Nút về trang chủ (ghost) ─────────────────
              OutlinedActionButton(
                label: 'BACK TO HOME',
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                ),
              ),
              const SizedBox(height: 28),

              // ─── Link gửi lại email ──────────────────────
              Center(
                child: RichText(
                  text: TextSpan(
                    style: AppTextStyles.linkNormal,
                    children: [
                      const TextSpan(
                          text: 'You have not received the email? '),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {},
                          child: Text('Resend', style: AppTextStyles.link),
                        ),
                      ),
                    ],
                  ),
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
