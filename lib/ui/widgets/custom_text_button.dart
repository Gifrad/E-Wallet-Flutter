import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class CustomTextButton extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final VoidCallback? onPressed;
  const CustomTextButton({
    super.key,
    this.width = double.infinity,
    this.height = 24,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: greyTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
