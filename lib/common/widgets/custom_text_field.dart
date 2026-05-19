import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import '../../utils/app_assets.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.isPassword = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppTextStyles.label),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword && _obscure,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textDark,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppTextStyles.hint,
            filled: true,
            fillColor: AppColors.inputFill,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.inputBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.inputBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: () => setState(() => _obscure = !_obscure),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        AppAssets.icEye,
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          _obscure
                              ? AppColors.textHint
                              : AppColors.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
