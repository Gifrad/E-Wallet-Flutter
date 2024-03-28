import 'package:bank_sha/blocs/operator_card/opeartor_card_bloc.dart';
import 'package:bank_sha/models/operator-card/operator_card_model.dart';
import 'package:bank_sha/shared/shared_method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/pages/buy_data/data_provider/widget/data_provider_item.dart';
import 'package:bank_sha/ui/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/auth/auth_bloc.dart';

class DataProviderPage extends StatefulWidget {
  const DataProviderPage({super.key});

  @override
  State<DataProviderPage> createState() => _DataProviderPageState();
}

class _DataProviderPageState extends State<DataProviderPage> {
  OperatorCardModel? selectedOparatorCard;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beli Data'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            'From Wallet',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Image.asset(
                'assets/img_wallet.png',
                width: 80,
              ),
              const SizedBox(
                width: 16,
              ),
              BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                if (state is AuthSuccess) {
                  return Column(
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
                        'Balance: ${formatCurrency((int.parse(state.user.balance == null ? state.user.balance! : '0')))}',
                        style: greyTextStyle.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              })
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            'Select Provider',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          BlocBuilder<OpeartorCardBloc, OpeartorCardState>(
            builder: (context, state) {
              if (state is OpeartorCardSuccess) {
                return Column(
                  children: state.operatorCard
                      .map(
                        (operatorCard) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedOparatorCard = operatorCard;
                            });
                          },
                          child: DataProviderItem(
                            operatorCard: operatorCard,
                            isSelected:
                                operatorCard.id == selectedOparatorCard?.id,
                          ),
                        ),
                      )
                      .toList(),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )
        ],
      ),
      floatingActionButton: (selectedOparatorCard != null)
          ? Padding(
              padding: const EdgeInsets.all(24),
              child: CustomFilledButton(
                title: 'Continue',
                onPressed: () {
                  Navigator.pushNamed(context, '/data-package',
                      arguments: selectedOparatorCard);
                },
              ),
            )
          : const SizedBox.shrink(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
