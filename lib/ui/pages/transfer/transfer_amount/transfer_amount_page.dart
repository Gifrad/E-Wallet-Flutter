import 'package:bank_sha/blocs/transfer/transfer_bloc.dart';
import 'package:bank_sha/models/transaction/transfer_form_model.dart';
import 'package:bank_sha/shared/shared_method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/pages/pin/widget/pin_input_button.dart';
import 'package:bank_sha/ui/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../blocs/auth/auth_bloc.dart';

class TransferAmountPage extends StatefulWidget {
  const TransferAmountPage({super.key});

  @override
  State<TransferAmountPage> createState() => _TransferAmountPageState();
}

class _TransferAmountPageState extends State<TransferAmountPage> {
  late TextEditingController amountController;

  @override
  void initState() {
    amountController = TextEditingController(text: '0');

    amountController.addListener(() {
      final text = amountController.text;

      if (amountController.value.text.isNotEmpty) {
        amountController.value = amountController.value.copyWith(
          text: NumberFormat.currency(
            locale: 'id',
            decimalDigits: 0,
            symbol: '',
          ).format(
            int.parse(
              text.replaceAll('.', ''),
            ),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  void addAmount(String number) {
    if (amountController.text == '0') {
      amountController.text = '';
    }
    setState(() {
      amountController.text = amountController.text + number;
    });
  }

  void deleteAmount() {
    if (amountController.text.isNotEmpty) {
      setState(() {
        amountController.text = amountController.text.substring(
          0,
          amountController.text.length - 1,
        );
        if (amountController.text == '') {
          amountController.text = '0';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as TransferFormModel;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: darkBackgroundColor,
      body: BlocConsumer<TransferBloc, TransferState>(
        listener: (context, state) {
          if (state is TransferFailed) {
            customSnackBar(context, state.e);
          }

          if (state is TransferSuccess) {
            final amount = num.parse(amountController.text.replaceAll('.', ''));
            final resultAmount = amount * -1;
            context.read<AuthBloc>().add(
                  AuthUpdateBalance(resultAmount.toString()),
                );
            Navigator.pushNamedAndRemoveUntil(
                context, '/transfer-success', (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 58,
            ),
            children: [
              const SizedBox(
                height: 36,
              ),
              Center(
                child: Text(
                  'Total Amount',
                  style: whiteTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semibold,
                  ),
                ),
              ),
              const SizedBox(
                height: 67,
              ),
              Align(
                child: SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: amountController,
                    enabled: false,
                    cursorColor: greyColor,
                    style: whiteTextStyle.copyWith(
                      fontSize: 36,
                      fontWeight: medium,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Text(
                        'Rp ',
                        style: whiteTextStyle.copyWith(
                          fontSize: 36,
                          fontWeight: medium,
                        ),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: greyColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 66,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 40,
                runSpacing: 40,
                children: [
                  PinInputButton(
                    title: '1',
                    onTap: () {
                      addAmount('1');
                    },
                  ),
                  PinInputButton(
                    title: '2',
                    onTap: () {
                      addAmount('2');
                    },
                  ),
                  PinInputButton(
                    title: '3',
                    onTap: () {
                      addAmount('3');
                    },
                  ),
                  PinInputButton(
                    title: '4',
                    onTap: () {
                      addAmount('4');
                    },
                  ),
                  PinInputButton(
                    title: '5',
                    onTap: () {
                      addAmount('5');
                    },
                  ),
                  PinInputButton(
                    title: '6',
                    onTap: () {
                      addAmount('6');
                    },
                  ),
                  PinInputButton(
                    title: '7',
                    onTap: () {
                      addAmount('7');
                    },
                  ),
                  PinInputButton(
                    title: '8',
                    onTap: () {
                      addAmount('8');
                    },
                  ),
                  PinInputButton(
                    title: '9',
                    onTap: () {
                      addAmount('9');
                    },
                  ),
                  const SizedBox(
                    height: 60,
                    width: 60,
                  ),
                  PinInputButton(
                    title: '0',
                    onTap: () {
                      addAmount('0');
                    },
                  ),
                  InkWell(
                    onTap: () {
                      deleteAmount();
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: numberBackgroundColor),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              CustomFilledButton(
                title: 'Continue',
                onPressed: () async {
                  if (await Navigator.pushNamed(context, '/pin') == true) {
                    final authState = context.read<AuthBloc>().state;
                    String pin = '';
                    if (authState is AuthSuccess) {
                      pin = authState.user.pin!;
                    }

                    context.read<TransferBloc>().add(
                          TransferPost(
                            args.copyWith(
                              pin: pin,
                              amount: amountController.text.replaceAll('.', ''),
                              sendTo: args.sendTo,
                            ),
                          ),
                        );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
