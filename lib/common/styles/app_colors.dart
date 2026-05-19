import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ─── Màu chủ đạo ───────────────────────────────────────
  static const Color primary = Color(0xFF29264A); // xanh navy đậm
  static const Color primaryLight = Color(0xFFEEEDF5); // navy nhạt, dùng cho nền nút phụ

  // ─── Màu nhấn (accent) ────────────────────────────────
  static const Color accent = Color(0xFFF6A623); // cam nổi bật

  // ─── Nền màn hình ──────────────────────────────────────
  static const Color background = Color(0xFFFFFFFF);
  static const Color scaffoldBg = Color(0xFFF9F9F9);
  static const Color splashBg = Color(0xFF29264A); // trùng với primary, dùng cho màn logo

  // ─── Màu chữ ───────────────────────────────────────────
  static const Color textDark = Color(0xFF1A1A2E);
  static const Color textBody = Color(0xFF4A4A6A);
  static const Color textHint = Color(0xFFAAAAAA);
  static const Color textLink = Color(0xFF29264A);

  // ─── Input / Viền ──────────────────────────────────────
  static const Color inputBorder = Color(0xFFDDDDE8);
  static const Color inputFill = Color(0xFFF7F7F9); // nền nhẹ bên trong ô nhập

  // ─── Divider / Bề mặt ──────────────────────────────────
  static const Color divider = Color(0xFFE8E8F0);
  static const Color white = Color(0xFFFFFFFF);
}
