import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/home_send_again_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/user/user_bloc.dart';
import '../../../../models/transaction/transfer_form_model.dart';

class BuildSendAgain extends StatelessWidget {
  const BuildSendAgain({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send Again',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
          BlocProvider(
            create: (context) => UserBloc()..add(UserGetRecent()),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserSuccess) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: state.user.isNotEmpty
                          ? state.user
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
                                  child: HomeSendAgainItem(user: user)))
                              .toList()
                          : [const Text('NOT FOUND')],
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
