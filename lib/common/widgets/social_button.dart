import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../styles/app_colors.dart';

/// Social sign-in button (Google / Apple) with icon
class SocialButton extends StatelessWidget {
  final String label;
  final String iconAsset;

  /// Set true để dùng Google "G" widget thay vì SVG
  /// (vì ic_google.svg dùng xlink:href + pattern không support bởi flutter_svg)
  final bool useGoogleIcon;
  final VoidCallback? onPressed;

  const SocialButton({
    super.key,
    required this.label,
    required this.iconAsset,
    this.useGoogleIcon = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.textDark,
          side: const BorderSide(color: AppColors.inputBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ─── Icon: Google "G" hoặc SVG thông thường ───
            useGoogleIcon
                ? _GoogleIcon()
                : SvgPicture.asset(
                    iconAsset,
                    width: 22,
                    height: 22,
                    fit: BoxFit.contain,
                  ),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Google "G" logo được vẽ bằng CustomPainter theo màu chuẩn Google
class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22,
      height: 22,
      child: CustomPaint(
        painter: _GoogleGPainter(),
      ),
    );
  }
}

class _GoogleGPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double r = size.width / 2;

    // ─── Vẽ 4 cung tròn màu Google ─────────────────────
    // Red (top-right)
    _drawArc(canvas, cx, cy, r, -10, 100, const Color(0xFFEA4335));
    // Yellow (bottom-right)
    _drawArc(canvas, cx, cy, r, 90, 80, const Color(0xFFFBBC05));
    // Green (bottom-left)
    _drawArc(canvas, cx, cy, r, 170, 80, const Color(0xFF34A853));
    // Blue (left)
    _drawArc(canvas, cx, cy, r, 250, 100, const Color(0xFF4285F4));

    // ─── Xóa trung tâm để tạo hình vành khuyên ─────────
    final clearPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(cx, cy), r * 0.58, clearPaint);

    // ─── Vẽ thanh ngang của chữ G (phần xanh mở rộng) ──
    final bluePaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;

    // Rect ở góc phải, 1/2 dưới cùng của vòng tròn
    final rect = Rect.fromLTRB(cx, cy - r * 0.13, cx + r, cy + r * 0.13);
    canvas.drawRect(rect, bluePaint);

    // Che phần thừa bên ngoài vòng tròn
    final clipPath = Path()..addOval(Rect.fromCircle(center: Offset(cx, cy), radius: r));
    canvas.clipPath(clipPath);
    canvas.drawRect(rect, bluePaint);
  }

  void _drawArc(Canvas canvas, double cx, double cy, double r,
      double startDeg, double sweepDeg, Color color) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * 0.42
      ..strokeCap = StrokeCap.butt;

    final startRad = startDeg * 3.14159265 / 180;
    final sweepRad = sweepDeg * 3.14159265 / 180;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r * 0.79),
      startRad,
      sweepRad,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

