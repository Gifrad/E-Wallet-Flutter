import 'package:bank_sha/models/transaction/transaction_model.dart';
import 'package:bank_sha/shared/shared_method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeLatestTransactionsItem extends StatelessWidget {
  final TransactionModel transaction;
  const HomeLatestTransactionsItem({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          transaction.transactionTypeModel!.thumbnail.toString(),
          width: 48,
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.transactionTypeModel!.name.toString(),
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semibold,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                DateFormat('MMM dd yyyy')
                    .format(transaction.createdAt ?? DateTime.now()),
                style: greyTextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Text(
          formatCurrency(
              num.parse(transaction.amount ?? '0'),
              symbol: transaction.transactionTypeModel!.action == 'cr'
                  ? '+ '
                  : '- '),
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: medium,
          ),
        ),
      ],
    );
  }
}
