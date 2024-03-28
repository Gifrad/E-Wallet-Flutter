import 'package:bank_sha/shared/theme.dart';
import 'package:flutter/material.dart';

class HomeItemsServices extends StatelessWidget {
  final String urlIcon;
  final String title;
  final VoidCallback? onTap;

  const HomeItemsServices({
    super.key,
    required this.urlIcon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: whiteColor,
            ),
            child: Center(
              child: Image.asset(
                urlIcon,
                width: 26,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          title,
          style: blackTextStyle.copyWith(fontWeight: medium),
        ),
      ],
    );
  }
}
