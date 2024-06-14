import 'package:app/src/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:internal_core/internal_core.dart';

class WidgetProblemLoading extends StatelessWidget {
  final VoidCallback callback;
  const WidgetProblemLoading({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: callback,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            WidgetAppSVG(
              'empty',
              width: 40.sw,
              color: appColorText.withOpacity(.5),
            ),
            Gap(8.sw),
            Text(
              "The sky is so blue!\nBut something's not right here...\nProblem loading collection"
                  .tr(),
              textAlign: TextAlign.center,
              style: w400TextStyle(
                fontSize: 16.sw,
                color: appColorText.withOpacity(.5),
              ),
            ),
            Gap(8.sw),
            Text(
              "Click here to try again!".tr(),
              textAlign: TextAlign.center,
              style: w400TextStyle(
                  fontSize: 16.sw,
                  color: appColorText.withOpacity(.8),
                  decoration: TextDecoration.underline),
            ),
          ],
        ),
      ),
    );
  }
}
