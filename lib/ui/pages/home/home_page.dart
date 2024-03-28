import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/pages/home/widget/build_friendly_tips.dart';
import 'package:bank_sha/ui/pages/home/widget/build_latest_transactions.dart';
import 'package:bank_sha/ui/pages/home/widget/build_level.dart';
import 'package:bank_sha/ui/pages/home/widget/build_profile.dart';
import 'package:bank_sha/ui/pages/home/widget/build_send_again.dart';
import 'package:bank_sha/ui/pages/home/widget/build_services.dart';
import 'package:bank_sha/ui/pages/home/widget/build_wallet_card.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: whiteColor,
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        notchMargin: 6,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: whiteColor,
          selectedItemColor: blueColor,
          unselectedItemColor: blackColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: blueTextStyle.copyWith(
            fontSize: 10,
            fontWeight: medium,
          ),
          unselectedLabelStyle: blackTextStyle.copyWith(
            fontSize: 10,
            fontWeight: medium,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/ic_overview.png',
                width: 20,
                color: blueColor,
              ),
              label: 'Overview',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/ic_history.png',
                width: 20,
              ),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/ic_statistic.png',
                width: 20,
              ),
              label: 'Statistic',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/ic_reward.png',
                width: 20,
              ),
              label: 'Reward',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: purpleColor,
        child: Image.asset(
          'assets/ic_plus_circle.png',
          width: 24,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        children: const [
          BuildProfile(),
          BuildWalletCard(),
          BuildLevel(),
          BuildServices(),
          BuildLatestTransactions(),
          BuildSendAgain(),
          BuildFriendlyTips(),
        ],
      ),
    );
  }
}
