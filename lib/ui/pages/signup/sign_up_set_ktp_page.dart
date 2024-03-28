import 'dart:convert';
import 'dart:io';

import 'package:bank_sha/models/auth/sign_up_form_model.dart';
import 'package:bank_sha/ui/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../blocs/auth/auth_bloc.dart';
import '../../../shared/shared_method.dart';
import '../../../shared/theme.dart';
import '../../widgets/custom_filled_button.dart';

class SignUpSetKtpPage extends StatefulWidget {
  const SignUpSetKtpPage({super.key});

  @override
  State<SignUpSetKtpPage> createState() => _SignUpSetKtpPageState();
}

class _SignUpSetKtpPageState extends State<SignUpSetKtpPage> {
  XFile? selectedImage;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SignUpFormModel;
    print(args.toJson());
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            customSnackBar(context, state.e);
          }

          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/sign-up-success', (route) => false,
                arguments: state.user);
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
              horizontal: 24,
            ),
            children: [
              Container(
                width: 155,
                height: 50,
                margin: const EdgeInsets.only(
                  top: 100,
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/img_logo_light.png',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Text(
                'Verify Your\nAccount',
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semibold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: whiteColor,
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final image = await selectImage();
                        setState(() {
                          selectedImage = image;
                        });
                      },
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: lightBackgroundColor,
                          image: selectedImage == null
                              ? null
                              : DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                    File(selectedImage!.path),
                                  ),
                                ),
                        ),
                        child: selectedImage != null
                            ? null
                            : Center(
                                child: Image.asset(
                                  'assets/ic_upload.png',
                                  width: 32,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Passport/ID Card',
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    CustomFilledButton(
                      title: 'Continue',
                      onPressed: () {
                        if (passportValidate(selectedImage)) {
                          context.read<AuthBloc>().add(
                                AuthRegister(
                                  args.copyWith(
                                    ktp: selectedImage == null
                                        ? ''
                                        : 'data:image/png;base64,${base64Encode(File(selectedImage!.path).readAsBytesSync())}',
                                  ),
                                ),
                              );
                        } else {
                          customSnackBar(context, 'Gambar tidak boleh kosong');
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              CustomTextButton(
                title: 'Skip for Now',
                onPressed: () {
                  context.read<AuthBloc>().add(
                        AuthRegister(args.copyWith(ktp: '')),
                      );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
