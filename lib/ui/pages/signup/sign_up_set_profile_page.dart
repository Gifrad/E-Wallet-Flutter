import 'dart:convert';
import 'dart:io';

import 'package:bank_sha/models/auth/sign_up_form_model.dart';
import 'package:bank_sha/shared/shared_method.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/theme.dart';
import '../../widgets/custom_filled_button.dart';
import '../../widgets/custom_form_field.dart';

class SignUpSetProfilePage extends StatefulWidget {
  const SignUpSetProfilePage({super.key});

  @override
  State<SignUpSetProfilePage> createState() => _SignUpSetProfilePageState();
}

class _SignUpSetProfilePageState extends State<SignUpSetProfilePage> {
  late TextEditingController pinController;
  XFile? selectedImage;

  @override
  void initState() {
    pinController = TextEditingController(text: '');
    super.initState();
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SignUpFormModel;
    return Scaffold(
      body: ListView(
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
            'Join Us to Unlock\nYour Growth',
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
                  'Shayna Hanna',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomFormField(
                  keyboardType: TextInputType.number,
                  title: 'Set PIN (6 digit number)',
                  controller: pinController,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomFilledButton(
                  title: 'Continue',
                  onPressed: () {
                    if (pinController.text.isEmpty) {
                      customSnackBar(context, 'Field PIN harus diisi');
                    } else {
                      if (pinValidate(pinController)) {
                        Navigator.pushNamed(
                          context,
                          '/sign-up-set-ktp',
                          arguments: args.copyWith(
                            pin: pinController.text,
                            profilePicture: selectedImage == null 
                                ? ''
                                : 'data:image/png;base64,${base64Encode(File(selectedImage!.path).readAsBytesSync())}',
                          ),
                        );
                      } else {
                        customSnackBar(context, 'PIN harus 6 digit');
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
