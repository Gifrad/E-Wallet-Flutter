import 'package:bank_sha/blocs/data_plan/data_plan_bloc.dart';
import 'package:bank_sha/models/data-plan/data_plan_form.dart';
import 'package:bank_sha/models/data-plan/data_plan_model.dart';
import 'package:bank_sha/models/operator-card/operator_card_model.dart';
import 'package:bank_sha/shared/shared_method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/pages/buy_data/data_package/widget/data_package_item.dart';
import 'package:bank_sha/ui/widgets/custom_filled_button.dart';
import 'package:bank_sha/ui/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/auth/auth_bloc.dart';

class DataPackagePage extends StatefulWidget {
  const DataPackagePage({super.key});

  @override
  State<DataPackagePage> createState() => _DataPackagePageState();
}

class _DataPackagePageState extends State<DataPackagePage> {
  late TextEditingController phoneController;
  DataPlanModel? selectedDataPlan;

  @override
  void initState() {
    phoneController = TextEditingController(text: '');
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as OperatorCardModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beli Paket'),
      ),
      body: BlocConsumer<DataPlanBloc, DataPlanState>(
        listener: (context, state) {
          if (state is DataPlanFailed) {
            customSnackBar(context, state.e);
          }

          if (state is DataPlanSuccess) {
            final price = num.parse(selectedDataPlan!.price!);
            final customePrice = price * -1;
            context
                .read<AuthBloc>()
                .add(AuthUpdateBalance(customePrice.toString()));

            Navigator.pushNamedAndRemoveUntil(
                context, '/data-success', (route) => false);
          }
        },
        builder: (context, state) {
          if (state is DataPlanLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                'Phone Number',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semibold,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              CustomFormField(
                title: '+628',
                isShowTitle: false,
                controller: phoneController,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'Select Package',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semibold,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Wrap(
                spacing: 18,
                runSpacing: 18,
                children: args.dataPlans!
                    .map(
                      (dataPlan) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDataPlan = dataPlan;
                          });
                          
                        },
                        child: DataPackageItem(
                          dataPlan: dataPlan,
                          isSelected: dataPlan.id == selectedDataPlan?.id,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          );
        },
      ),
      floatingActionButton:
          (selectedDataPlan != null && phoneController.text.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.all(24),
                  child: CustomFilledButton(
                    title: 'Continue',
                    onPressed: () async {
                      if (await Navigator.pushNamed(context, '/pin') == true) {
                        final authState = context.read<AuthBloc>().state;
                        String pin = '';
                        if (authState is AuthSuccess) {
                          pin = authState.user.pin!;
                        }

                        context.read<DataPlanBloc>().add(
                              DataPlanPost(
                                DataPlanForm(
                                  dataPlanId: selectedDataPlan!.id,
                                  phoneNumber: phoneController.text,
                                  pin: pin,
                                ),
                              ),
                            );
                      }
                    },
                  ),
                )
              : const SizedBox.shrink(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
