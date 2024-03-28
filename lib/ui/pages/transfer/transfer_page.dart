import 'package:bank_sha/blocs/user/user_bloc.dart';
import 'package:bank_sha/models/auth/user_model.dart';
import 'package:bank_sha/models/transaction/transfer_form_model.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/pages/transfer/widget/recent_item.dart';
import 'package:bank_sha/ui/pages/transfer/widget/result_item.dart';
import 'package:bank_sha/ui/widgets/custom_filled_button.dart';
import 'package:bank_sha/ui/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  late TextEditingController usernameController;
  UserModel? selectedUser;

  late UserBloc userBloc;

  @override
  void initState() {
    usernameController = TextEditingController(text: '');
    userBloc = context.read<UserBloc>()..add(UserGetRecent());
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            'Search',
            style: blackTextStyle.copyWith(
              fontSize: 26,
              fontWeight: semibold,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          CustomFormField(
            title: 'by username',
            isShowTitle: false,
            controller: usernameController,
            onFiledSubmitted: (value) {
              if (value.isNotEmpty) {
                userBloc.add(UserGetByUsername(usernameController.text));
              } else {
                selectedUser = null;
                userBloc.add(UserGetRecent());
              }
              setState(() {});
            },
          ),
          usernameController.text.isEmpty ? buildRecent() : buildResult(),
        ],
      ),
      floatingActionButton: selectedUser != null
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomFilledButton(
                title: 'Continue',
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/transfer-amount',
                    arguments: TransferFormModel(
                      sendTo: selectedUser!.username,
                    ),
                  );
                },
              ),
            )
          : const SizedBox.shrink(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Container buildRecent() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Users',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserSuccess) {
                return Column(
                  children: state.user
                      .map((user) => GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/transfer-amount',
                              arguments: TransferFormModel(
                                sendTo: user.username,
                              ),
                            );
                          },
                          child: RecentItem(user: user)))
                      .toList(),
                );
              }
              if (state is UserFailed) {
                return Center(
                  child: Text(state.e),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }

  Widget buildResult() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Result',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Center(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserSuccess) {
                  return Wrap(
                    spacing: 17,
                    runSpacing: 14,
                    children: state.user
                        .map(
                          (user) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedUser = user;
                              });
                            },
                            child: ResultItem(
                              user: user,
                              isSelected: user.id == selectedUser?.id,
                            ),
                          ),
                        )
                        .toList(),
                  );
                }
                if (state is UserFailed) {
                  Center(
                    child: Center(child: Text(state.e)),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}
