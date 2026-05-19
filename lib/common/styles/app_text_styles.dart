import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // ─── Tiêu đề màn hình ──────────────────────────────────
  /// Dùng cho các tiêu đề chính: "Welcome Back", "Create an Account", v.v.
  static const TextStyle heading = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
    letterSpacing: -0.3,
  );

  /// Phần tiêu đề nhấn màu cam, ví dụ: "Dream Job"
  static const TextStyle headingAccent = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: AppColors.accent,
    letterSpacing: -0.3,
  );

  // ─── Mô tả / Thân bài ─────────────────────────────────
  static const TextStyle subHeading = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textBody,
    height: 1.5,
  );

  // ─── Nhãn trên ô nhập liệu ─────────────────────────────
  static const TextStyle label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  // ─── Placeholder / gợi ý ──────────────────────────────
  static const TextStyle hint = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
  );

  // ─── Chữ trên nút bấm ─────────────────────────────────
  static const TextStyle button = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.8,
    color: AppColors.white,
  );

  // nút outlined dùng chữ màu navy
  static const TextStyle buttonOutlined = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: AppColors.primary,
  );

  // ─── Link / Liên kết ───────────────────────────────────
  static const TextStyle link = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
    decoration: TextDecoration.underline,
  );

  // text thường đi kèm link, không gạch chân
  static const TextStyle linkNormal = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textBody,
  );

  // ─── Màn hình Splash / Logo ────────────────────────────
  static const TextStyle logoTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    letterSpacing: 1,
  );

  static const TextStyle splashTitle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
    height: 1.25,
  );

  static const TextStyle splashTitleAccent = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColors.accent,
    height: 1.25,
  );

  static const TextStyle splashBody = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textBody,
    height: 1.5,
  );
}
