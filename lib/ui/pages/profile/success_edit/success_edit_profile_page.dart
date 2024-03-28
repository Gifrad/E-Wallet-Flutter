import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';

class SuccessEditProfilePage extends StatelessWidget {
  const SuccessEditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nice Update!',
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semibold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 26,
            ),
            Text(
              'Your data is safe with\nour system',
              style: greyTextStyle.copyWith(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            CustomFilledButton(
              title: 'My Profile',
              onPressed: () {
                Navigator.pop(context);
              },
              width: 183,
            )
          ],
        ),
      ),
    );
  }
}
