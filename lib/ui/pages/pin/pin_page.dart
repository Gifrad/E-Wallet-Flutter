import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/shared/shared_method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/pages/pin/widget/pin_input_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinPage extends StatefulWidget {
  const PinPage({super.key});

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  late TextEditingController pinController;
  String pin = '';
  bool isError = false;

  @override
  void initState() {
    pinController = TextEditingController();
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      pin = authState.user.pin!;
    }
    super.initState();
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  void addNumber(String number) {
    if (pinController.text.length < 6) {
      setState(() {
        pinController.text = pinController.text + number;
      });
    }

    if (pinController.text.length == 6) {
      if (pinController.text == pin) {
        Navigator.pop(context, true);
      } else {
        setState(() {
          isError = true;
        });
        Future.delayed(const Duration(seconds: 2), (){
           pinController.clear();
           isError = false;
        });
        customSnackBar(
          context,
          'PIN yang anda masukkan salah. Silakan coba lagi.',
        );
      }
    }
  }

  void deleteNumber() {
    if (pinController.text.isNotEmpty) {
      setState(() {
        isError = false;
        pinController.text = pinController.text.substring(
          0,
          pinController.text.length - 1,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: darkBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 58,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sha PIN',
                style: whiteTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semibold,
                ),
              ),
              const SizedBox(
                height: 72,
              ),
              SizedBox(
                width: 200,
                child: TextFormField(
                  controller: pinController,
                  obscureText: true,
                  enabled: false,
                  obscuringCharacter: "*",
                  cursorColor: greyColor,
                  style: whiteTextStyle.copyWith(
                      fontSize: 36,
                      fontWeight: medium,
                      letterSpacing: 16,
                      color: isError ? redColor : whiteColor),
                  decoration: InputDecoration(
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: greyColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 66,
              ),
              Wrap(
                spacing: 40,
                runSpacing: 40,
                children: [
                  PinInputButton(
                    title: '1',
                    onTap: () {
                      addNumber('1');
                    },
                  ),
                  PinInputButton(
                    title: '2',
                    onTap: () {
                      addNumber('2');
                    },
                  ),
                  PinInputButton(
                    title: '3',
                    onTap: () {
                      addNumber('3');
                    },
                  ),
                  PinInputButton(
                    title: '4',
                    onTap: () {
                      addNumber('4');
                    },
                  ),
                  PinInputButton(
                    title: '5',
                    onTap: () {
                      addNumber('5');
                    },
                  ),
                  PinInputButton(
                    title: '6',
                    onTap: () {
                      addNumber('6');
                    },
                  ),
                  PinInputButton(
                    title: '7',
                    onTap: () {
                      addNumber('7');
                    },
                  ),
                  PinInputButton(
                    title: '8',
                    onTap: () {
                      addNumber('8');
                    },
                  ),
                  PinInputButton(
                    title: '9',
                    onTap: () {
                      addNumber('9');
                    },
                  ),
                  const SizedBox(
                    height: 60,
                    width: 60,
                  ),
                  PinInputButton(
                    title: '0',
                    onTap: () {
                      addNumber('0');
                    },
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {
                      deleteNumber();
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
