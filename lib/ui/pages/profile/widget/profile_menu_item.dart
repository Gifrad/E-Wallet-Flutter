import 'package:bank_sha/shared/theme.dart';
import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final String urlIcon;
  final String title;
  final VoidCallback? onTap;
  const ProfileMenuItem({
    super.key,
    required this.urlIcon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            urlIcon,
            width: 24,
          ),
          const SizedBox(
            width: 18,
          ),
          Text(
            title,
            style: blackTextStyle.copyWith(
              fontWeight: medium,
            ),
          ),
        ],
      ),
    );
  }
}
