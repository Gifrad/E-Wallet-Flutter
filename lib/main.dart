import 'package:bank_sha/blocs/data_plan/data_plan_bloc.dart';
import 'package:bank_sha/blocs/operator_card/opeartor_card_bloc.dart';
import 'package:bank_sha/blocs/payment_method/payment_method_bloc.dart';
import 'package:bank_sha/blocs/tips/tips_bloc.dart';
import 'package:bank_sha/blocs/top_up/top_up_bloc.dart';
import 'package:bank_sha/blocs/transaction/transaction_bloc.dart';
import 'package:bank_sha/blocs/transfer/transfer_bloc.dart';
import 'package:bank_sha/blocs/user/user_bloc.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/pages/buy_data/data_package/data_package_page.dart';
import 'package:bank_sha/ui/pages/buy_data/data_provider/data_provider_page.dart';
import 'package:bank_sha/ui/pages/buy_data/data_success/data_success_page.dart';
import 'package:bank_sha/ui/pages/profile/edit_pin/pofile_edit_pin_page.dart';
import 'package:bank_sha/ui/pages/profile/edit_profile/edit_profile_page.dart';
import 'package:bank_sha/ui/pages/home/home_page.dart';
import 'package:bank_sha/ui/pages/onboarding/onboarding_page.dart';
import 'package:bank_sha/ui/pages/pin/pin_page.dart';
import 'package:bank_sha/ui/pages/profile/profile_page.dart';
import 'package:bank_sha/ui/pages/profile/success_edit/success_edit_profile_page.dart';
import 'package:bank_sha/ui/pages/signin/sign_in_page.dart';
import 'package:bank_sha/ui/pages/signup/sign_up_page.dart';
import 'package:bank_sha/ui/pages/signup/sign_up_set_ktp_page.dart';
import 'package:bank_sha/ui/pages/signup/sign_up_set_profile_page.dart';
import 'package:bank_sha/ui/pages/signup/sign_up_success_page.dart';
import 'package:bank_sha/ui/pages/splash/splash_page.dart';
import 'package:bank_sha/ui/pages/topup/topup_amount/topup_amount_page.dart';
import 'package:bank_sha/ui/pages/topup/topup_page.dart';
import 'package:bank_sha/ui/pages/topup/topup_success/topup_success_page.dart';
import 'package:bank_sha/ui/pages/transfer/transfer_amount/transfer_amount_page.dart';
import 'package:bank_sha/ui/pages/transfer/transfer_page.dart';
import 'package:bank_sha/ui/pages/transfer/transfer_success/transfer_success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/auth/auth_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()
            ..add(
              AuthGetCurrentUser(),
            ),
        ),
        BlocProvider(
          create: (context) => PaymentMethodBloc()
            ..add(
              PaymentMethodGet(),
            ),
        ),
        BlocProvider(
          create: (context) => TopUpBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => TransferBloc(),
        ),
        BlocProvider(
          create: (context) => OpeartorCardBloc()..add(OperatorCardGet()),
        ),
        BlocProvider(
          create: (context) => DataPlanBloc(),
        ),
        BlocProvider(
          create: (context) => TransactionBloc(),
        ),
        BlocProvider(
          create: (context) => TipsBloc(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: lightBackgroundColor,
          appBarTheme: AppBarTheme(
            centerTitle: true,
            elevation: 0,
            backgroundColor: lightBackgroundColor,
            iconTheme: IconThemeData(
              color: blackColor,
            ),
            titleTextStyle: blackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semibold,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/onboarding': (context) => const OnboardingPage(),
          '/sign-in': (context) => const SignInPage(),
          '/sign-up': (context) => const SignUpPage(),
          '/sign-up-set-profile': (context) => const SignUpSetProfilePage(),
          '/sign-up-set-ktp': (context) => const SignUpSetKtpPage(),
          '/sign-up-success': (context) => const SignUpSuccessPage(),
          '/home': (context) => const HomePage(),
          '/profile': (context) => const ProfilePage(),
          '/pin': (context) => const PinPage(),
          '/edit-profile': (context) => const EditProfile(),
          '/edit-pin-profile': (context) => const EditPin(),
          '/success-edit-profile': (context) => const SuccessEditProfilePage(),
          '/topup': (context) => const TopupPage(),
          '/topup-amount': (context) => const TopupAmountPage(),
          '/topup-success': (context) => const TopupSuccessPage(),
          '/transfer': (context) => const TransferPage(),
          '/transfer-amount': (context) => const TransferAmountPage(),
          '/transfer-success': (context) => const TransferSuccessPage(),
          '/data-provider': (context) => const DataProviderPage(),
          '/data-package': (context) => const DataPackagePage(),
          '/data-success': (context) => const DataSuccessPage(),
        },
      ),
    );
  }
}
