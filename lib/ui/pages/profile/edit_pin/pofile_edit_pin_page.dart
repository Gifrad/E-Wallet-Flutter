import 'package:bank_sha/shared/shared_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/auth/auth_bloc.dart';
import '../../../../shared/theme.dart';
import '../../../widgets/custom_filled_button.dart';
import '../../../widgets/custom_form_field.dart';

class EditPin extends StatefulWidget {
  const EditPin({super.key});

  @override
  State<EditPin> createState() => _EditPinState();
}

class _EditPinState extends State<EditPin> {
  late TextEditingController oldPinController;
  late TextEditingController newPinController;

  @override
  void initState() {
    oldPinController = TextEditingController();
    newPinController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    oldPinController.dispose();
    newPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Pin'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            customSnackBar(context, state.e);
          }

          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, '/success-edit-profile');
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
                      title: 'Old PIN',
                      controller: oldPinController,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomFormField(
                      title: 'New PIN',
                      obscureText: true,
                      controller: newPinController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomFilledButton(
                      title: 'Update Now',
                      onPressed: () {
                        if (oldPinController.text.length != 6 ||
                            newPinController.text.length != 6) {
                          customSnackBar(context, 'Pin harus 6 Digit');
                        } else {
                          context.read<AuthBloc>().add(
                                AuthUpdatePin(
                                  oldPinController.text,
                                  newPinController.text,
                                ),
                              );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
