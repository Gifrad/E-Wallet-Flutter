import 'package:bank_sha/models/data-plan/data_plan_model.dart';
import 'package:bank_sha/shared/shared_method.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/theme.dart';

class DataPackageItem extends StatelessWidget {
  final DataPlanModel dataPlan;
  final bool? isSelected;
  const DataPackageItem({
    super.key,
    required this.dataPlan,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 45,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: whiteColor,
        border: Border.all(
          width: 2,
          color: isSelected == true ? blueColor : whiteColor,
        ),
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              dataPlan.name.toString(),
              style: blackTextStyle.copyWith(
                fontSize: 32,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              formatCurrency(num.parse(dataPlan.price ?? '0')),
              style: greyTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
