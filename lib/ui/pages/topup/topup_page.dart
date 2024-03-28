import 'package:bank_sha/models/payment/payment_method_model.dart';
import 'package:bank_sha/models/transaction/top_up_form_model.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/pages/topup/widget/bank_item.dart';
import 'package:bank_sha/ui/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/auth/auth_bloc.dart';
import '../../../blocs/payment_method/payment_method_bloc.dart';

class TopupPage extends StatefulWidget {
  const TopupPage({super.key});

  @override
  State<TopupPage> createState() => _TopupPageState();
}

class _TopupPageState extends State<TopupPage> {
  PaymentMethodModel? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Up'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            'Wallet',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess) {
                return Row(
                  children: [
                    Image.asset(
                      'assets/img_wallet.png',
                      width: 80,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.user.cardNumber!.replaceAllMapped(
                              RegExp(r".{4}"), (match) => "${match.group(0)} "),
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          state.user.name!,
                          style: greyTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            'Select Bank',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
            builder: (context, state) {
              if (state is PaymentMethodSuccess) {
                return Column(
                  children: state.paymentMethods.map((paymentMethod) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPaymentMethod = paymentMethod;
                        });
                      },
                      child: BankItem(
                        isSelected:
                            selectedPaymentMethod?.id == paymentMethod.id,
                        paymentMethod: paymentMethod,
                      ),
                    );
                  }).toList(),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
      floatingActionButton: selectedPaymentMethod != null
          ? Container(
            margin: const EdgeInsets.all(24),
            child: CustomFilledButton(
                title: 'Continue',
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/topup-amount',
                    arguments: TopupFormModel(
                      paymentMethodeCode: selectedPaymentMethod?.code,
                    ),
                  );
                },
              ),
          )
          : const SizedBox.shrink(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
