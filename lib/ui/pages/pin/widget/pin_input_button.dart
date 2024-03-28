import 'package:bank_sha/shared/theme.dart';
import 'package:flutter/material.dart';

class PinInputButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const PinInputButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius:BorderRadius.circular(25) ,
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: numberBackgroundColor),
        child: Center(
          child: Text(
            title,
            style: whiteTextStyle.copyWith(
              fontSize: 22,
              fontWeight: semibold,
            ),
          ),
        ),
      ),
    );
  }
}
