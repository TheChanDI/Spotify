import 'package:flutter/material.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';

class AppTextField extends StatefulWidget {
  const AppTextField(
      {super.key,
      required this.titleLabel,
      this.obscureText,
      this.onChanged,
      this.onTap,
      this.keyboardType,
      this.controller});

  final String titleLabel;
  final bool? obscureText;
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        obscureText: widget.obscureText ?? false,
        decoration: InputDecoration(
          labelText: widget.titleLabel,
          labelStyle: const TextStyle(color: Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary.withOpacity(0.5)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ));
    ;
  }
}
