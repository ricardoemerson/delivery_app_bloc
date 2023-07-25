import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final double width;
  final double? height;
  final VoidCallback? onPressed;

  const Button({
    super.key,
    required this.label,
    required this.width,
    this.height = 45,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
