import 'package:internal_core/internal_core.dart';
import 'package:app/src/constants/app_sizes.dart';
import 'package:app/src/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class WidgetLanguagesSheet extends StatelessWidget {
  const WidgetLanguagesSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.sw),
          ),
          color: appColorBackground),
      padding: EdgeInsets.only(bottom: context.mediaQueryPadding.bottom + 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 8.sw,
          ),
          Center(
            child: Container(
              width: 55.sw,
              height: 4.5.sw,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(99)),
            ),
          ),
          SizedBox(
            height: 12.sw,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sw),
            child: Text(
              "App language".tr(),
              style: w400TextStyle(fontSize: 16.sw),
            ),
          ),
          SizedBox(
            height: 12.sw,
          ),
          Container(
            height: 1,
            color: appColorElement,
          ),
          SizedBox(
            height: 8.sw,
          ),
          ...appSupportedLocales.map((e) => _WidgetButton(
                title: 'languagecode_${e.languageCode}'.tr(),
                isSelected: getLocale().languageCode == e.languageCode,
                onTap: () {
                  appHaptic();
                  context.pop();
                  setLocale(e.languageCode);
                },
              )),
          SizedBox(
            height: 12.sw,
          ),
        ],
      ),
    );
  }
}

class _WidgetButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool isSelected;
  const _WidgetButton({
    super.key,
    required this.title,
    this.onTap,
    this.isSelected = true,
  });

  @override
  Widget build(BuildContext context) {
    return WidgetRippleButton(
      onTap: onTap,
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.sw, horizontal: 16.sw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Opacity(
              opacity: isSelected ? 1 : .45,
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.check_mark,
                    color: isSelected ? appColorPrimary : Colors.transparent,
                  ),
                  Gap(12.sw),
                  Expanded(
                    child: Text(
                      title,
                      style: w500TextStyle(
                        fontSize: 16.sw,
                        color: isSelected ? appColorPrimary : appColorText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
