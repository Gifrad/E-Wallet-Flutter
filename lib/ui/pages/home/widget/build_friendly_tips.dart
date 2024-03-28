import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/home_tips_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/tips/tips_bloc.dart';

class BuildFriendlyTips extends StatelessWidget {
  const BuildFriendlyTips({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 30,
        bottom: 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Friendly Tips',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          BlocProvider(
            create: (context) => TipsBloc()..add(TipsGet()),
            child: BlocBuilder<TipsBloc, TipsState>(
              builder: (context, state) {
                if (state is TipsSuccess) {
                  return Wrap(
                    spacing: 18,
                    runSpacing: 18,
                    children: state.tips.isNotEmpty
                        ? state.tips
                            .map(
                              (tips) => HomeTipsItem(tips: tips),
                            )
                            .toList()
                        : [const Center(child: Text('NOT FOUND'))],
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
