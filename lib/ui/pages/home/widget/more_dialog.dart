import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/home_items_services.dart';
import 'package:flutter/material.dart';

class MoreDialog extends StatelessWidget {
  const MoreDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      insetPadding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
      backgroundColor: lightBackgroundColor,
      alignment: Alignment.bottomCenter,
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.41,
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Do More With Us',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semibold,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Wrap(
              spacing: 29,
              runSpacing: 29,
              children: [
                HomeItemsServices(
                  urlIcon: 'assets/ic_product_data.png',
                  title: 'Data',
                  onTap: () {
                    Navigator.pushNamed(context, '/data-provider');
                  },
                ),
                HomeItemsServices(
                  urlIcon: 'assets/ic_product_water.png',
                  title: 'Water',
                  onTap: () {},
                ),
                HomeItemsServices(
                  urlIcon: 'assets/ic_product_stream.png',
                  title: 'Stream',
                  onTap: () {},
                ),
                HomeItemsServices(
                  urlIcon: 'assets/ic_product_movie.png',
                  title: 'Movie',
                  onTap: () {},
                ),
                HomeItemsServices(
                  urlIcon: 'assets/ic_product_food.png',
                  title: 'Food',
                  onTap: () {},
                ),
                HomeItemsServices(
                  urlIcon: 'assets/ic_product_travel.png',
                  title: 'Travel',
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
