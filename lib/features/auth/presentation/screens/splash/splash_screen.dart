import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../common/styles/app_colors.dart';
import '../../../../../common/styles/app_text_styles.dart';
import '../../../../../utils/app_assets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // nền trắng
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Tên thương hiệu góc trên bên phải
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  'Jobspot',
                  style: AppTextStyles.label.copyWith(
                    fontSize: 15,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Hình minh hoạ chính giữa
              Expanded(
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.illWelcome,
                  ),
                ),
              ),

              // Slogan
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Find Your\n',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                        height: 1.3,
                      ),
                    ),
                    TextSpan(
                      text: 'Dream Job\n',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accent, // màu cam
                        height: 1.3,
                      ),
                    ),
                    TextSpan(
                      text: 'Here!',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Mô tả ngắn
              Text(
                'Explore all the most exciting job roles based on your interest and study major.',
                style: AppTextStyles.splashBody,
              ),
              const SizedBox(height: 40),

              // Nút tiếp tục sang màn đăng nhập
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/login'),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: AppColors.white,
                      size: 26,
                    ),
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

