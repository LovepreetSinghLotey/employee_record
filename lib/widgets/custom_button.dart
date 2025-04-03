import 'package:flutter/material.dart';

/// Created by lovepreetsingh on 03,April,2025

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.color,
    required this.textColor,
    required this.onPressed,
  });

  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onPressed,
    child: Container(
      width: 73,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color, // Dynamic background color
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
    ),
  );
}