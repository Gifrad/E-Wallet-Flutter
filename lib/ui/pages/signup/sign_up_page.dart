import 'package:bank_sha/models/auth/sign_up_form_model.dart';
import 'package:bank_sha/shared/shared_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/auth/auth_bloc.dart';
import '../../../shared/theme.dart';
import '../../widgets/custom_filled_button.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/custom_text_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passController;

  bool validate() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    nameController = TextEditingController(text: '');
    emailController = TextEditingController(text: '');
    passController = TextEditingController(text: '');
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          final data = SignUpFormModel(
            name: nameController.text,
            email: emailController.text,
            password: passController.text,
          );
          if (state is AuthFailed) {
            customSnackBar(context, state.e);
          }

          if (state is AuthCheckEmailSuccess) {
            Navigator.pushNamed(
              context,
              '/sign-up-set-profile',
              arguments: data,
            );
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFormField(
                      controller: nameController,
                      title: 'Full Name',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomFormField(
                      controller: emailController,
                      title: 'Email Address',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomFormField(
                      title: 'Password',
                      controller: passController,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomFilledButton(
                      title: 'Continue',
                      onPressed: () {
                        if (validate()) {
                          context
                              .read<AuthBloc>()
                              .add(AuthCheckEmail(emailController.text));
                        } else {
                          customSnackBar(context, 'Semua field harus diisi');
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              CustomTextButton(
                title: 'Sign in',
                onPressed: () {
                  Navigator.pushNamed(context, '/sign-in');
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
