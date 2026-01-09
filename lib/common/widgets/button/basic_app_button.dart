import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  const BasicAppButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.height,
      this.isLoading});

  final VoidCallback onPressed;
  final String title;
  final double? height;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ?? false ? null : onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(height ?? 50),
          foregroundColor: Colors.white),
      child: (isLoading ?? false)
          ? const CircularProgressIndicator(
              color: Colors.white,
            )
          : Text(title),
    );
  }
}
