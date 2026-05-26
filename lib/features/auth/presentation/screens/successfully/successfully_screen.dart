import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../common/styles/app_colors.dart';
import '../../../../../common/styles/app_text_styles.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../utils/app_assets.dart';

class SuccessfullyScreen extends StatelessWidget {
  const SuccessfullyScreen({super.key});

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

              // Hình minh hoạ
              Center(
                child: SvgPicture.asset(
                  AppAssets.illSuccessfully,
                  height: 200,
                ),
              ),
              const SizedBox(height: 32),

              // Tiêu đề
              Text('Successfully', style: AppTextStyles.heading),
              const SizedBox(height: 12),
              Text(
                'Your password has been updated, please change your password regularly to avoid this happening.',
                style: AppTextStyles.subHeading,
              ),
              const SizedBox(height: 36),

              // Nút tiếp tục
              PrimaryButton(
                label: 'CONTINUE',
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                ),
              ),
              const SizedBox(height: 16),

              // Nút quay về màn hình chính
              OutlinedActionButton(
                label: 'BACK TO HOME',
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
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

