import 'package:bank_sha/models/auth/user_model.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:flutter/material.dart';

class ResultItem extends StatelessWidget {
  final UserModel user;
  final bool? isSelected;
  const ResultItem({
    super.key,
    required this.user,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: whiteColor,
        border: Border.all(
          width: 2,
          color: isSelected == true ? blueColor : whiteColor,
        ),
      ),
      child: Center(
        child: Column(
          children: [
            Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: user.profilePicture == ''
                        ? const AssetImage('assets/img_profile.png')
                        : NetworkImage(user.profilePicture!) as ImageProvider,
                  ),
                ),
                child: (user.verified == '1')
                    ? Align(
                        alignment: Alignment.topRight,
                        child: Image.asset(
                          'assets/ic_check.png',
                          width: 20,
                        ),
                      )
                    : null),
            const SizedBox(
              height: 14,
            ),
            Text(
              user.name!,
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              '@${user.username}',
              style: greyTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
