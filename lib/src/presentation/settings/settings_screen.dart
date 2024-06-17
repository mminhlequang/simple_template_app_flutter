import 'package:app/src/presentation/widgets/widget_app_switcher.dart';
import 'package:internal_core/internal_core.dart';
import 'package:app/src/constants/constants.dart';
import 'package:app/src/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'widgets/widget_languages_sheet.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(context.mediaQueryPadding.top + 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sw),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Settings'.tr(),
                        style: w600TextStyle(fontSize: 18.sw),
                      ),
                      Gap(2.sw),
                      Text(
                        'SKidEnglish',
                        style: w300TextStyle(fontSize: 12.sw),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: appChangedTheme,
                  icon: WidgetAppSVG(
                    AppPrefs.instance.isDarkTheme ? 'sun' : 'moon',
                    color: appColorText,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(vertical: 10.sw, horizontal: 16.sw),
            color: appColorElement,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(8.sw),
                  _WidgetSection(
                    title: "User Interface",
                    child: Column(
                      children: [
                        _WidgetButton(
                          asset: 'language',
                          title: "Language".tr(),
                          onTap: () {
                            appOpenBottomSheet(const WidgetLanguagesSheet());
                          },
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   height: 1,
                  //   margin: EdgeInsets.symmetric(vertical: 10.sw),
                  //   color: appColorElement,
                  // ),
                  // _WidgetSection(
                  //   title: "App Content",
                  //   child: Column(
                  //     children: [
                  //       _WidgetButton(
                  //         asset: 'chart-line',
                  //         title: "Period sort".tr(),
                  //         child: Column(
                  //             children: ['Week', 'Month', 'Year']
                  //                 .map(
                  //                   (e) => _WidgetButtonCheck(
                  //                     title: 'By ${e.toLowerCase()}'.tr(),
                  //                     onTap: () {
                  //                       appHaptic();
                  //                       AppPrefs.instance.period = e;
                  //                       setState(() {});
                  //                     },
                  //                     isSelected: AppPrefs.instance.period == e,
                  //                   ),
                  //                 )
                  //                 .toList()),
                  //       ),
                  //       _WidgetButton(
                  //         asset: 'tag',
                  //         title: "Tag favorite".tr(),
                  //         child: Column(
                  //           children: modelCubit.state.tags!
                  //               .map((e) => _WidgetButtonCheck(
                  //                     title: e.name?.capitalizeFirst ?? "",
                  //                     onTap: () {
                  //                       appHaptic();
                  //                       if (AppPrefs.instance.tag == e.name) {
                  //                         AppPrefs.instance.tag = null;
                  //                       } else {
                  //                         AppPrefs.instance.tag = e.name;
                  //                       }
                  //                       modelCubit.state.models = [];
                  //                       setState(() {});
                  //                     },
                  //                     isSelected:
                  //                         AppPrefs.instance.tag == e.name,
                  //                   ))
                  //               .toList(),
                  //         ),
                  //       ),
                  //       if (AppPrefs.instance.enableNsfw)
                  //         _WidgetButton(
                  //           asset: 'chart-donut',
                  //           title: "Not Safe For Work".tr(),
                  //           child: Column(
                  //             children: ['None', 'Soft', 'Mature', 'X']
                  //                 .map(
                  //                   (e) => _WidgetButtonCheck(
                  //                     title: e,
                  //                     onTap: () async {
                  //                       appHaptic();
                  //                       if (e != 'None') {
                  //                         var r = await nsfwWarningDialog();
                  //                         if (r != true) return;
                  //                       }
                  //                       modelCubit.state.models = [];
                  //                       AppPrefs.instance.nsfw = e;
                  //                       setState(() {});
                  //                     },
                  //                     isSelected: AppPrefs.instance.nsfw == e,
                  //                   ),
                  //                 )
                  //                 .toList(),
                  //           ),
                  //         ),
                  //       _WidgetButton(
                  //         asset: 'info-square',
                  //         title: "Show meta pormpt image".tr(),
                  //         rightAction: WidgetAppSwitcher(
                  //           value: AppPrefs.instance.enablePormpt,
                  //           onToggle: (value) {
                  //             appHaptic();
                  //             setState(() {
                  //               AppPrefs.instance.enablePormpt = value;
                  //             });
                  //           },
                  //         ),
                  //       ),
                  //       if (AppPrefs.instance.enableNsfw)
                  //         _WidgetButton(
                  //           asset: 'fade',
                  //           title: "Blur nsfw content".tr(),
                  //           rightAction: WidgetAppSwitcher(
                  //             value: AppPrefs.instance.blurNsfwImage,
                  //             onToggle: (value) {
                  //               appHaptic();
                  //               setState(() {
                  //                 AppPrefs.instance.blurNsfwImage = value;
                  //               });
                  //             },
                  //           ),
                  //         ),
                  //       _WidgetButton(
                  //         onTap: () {
                  //           appHaptic();
                  //           context.push('/hidden_content');
                  //         },
                  //         asset: 'eye-off',
                  //         title: "Manage hidden content".tr(),
                  //       ),

                  //     ],
                  //   ),
                  // ),
                  Container(
                    height: 1,
                    margin: EdgeInsets.symmetric(
                        vertical: 10.sw, horizontal: 16.sw),
                    color: appColorElement,
                  ),
                  Column(
                    children: [
                      _WidgetButton(
                        asset: 'external-link',
                        title: "Privacy terms".tr(),
                        onTap: () {
                          appHaptic();
                          launchUrlString(
                              "https://mminhlequang.github.io/privacy-policy/app.html");
                        },
                      ),
                      _WidgetButton(
                        asset: 'external-link',
                        title: "Contact us".tr(),
                        onTap: () {
                          appHaptic();
                          launchUrlString(
                              "mailto:mminh.lequang+privacy-policy@gmail.com?subject=Need help in app");
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WidgetButton extends StatefulWidget {
  final String asset;
  final String title;
  final Widget? child;
  final VoidCallback? onTap;
  final Widget? rightAction;
  const _WidgetButton({
    super.key,
    required this.title,
    this.child,
    required this.asset,
    this.onTap,
    this.rightAction,
  });

  @override
  State<_WidgetButton> createState() => __WidgetButtonState();
}

class __WidgetButtonState extends State<_WidgetButton> {
  bool isExplained = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetRippleButton(
          onTap: widget.child != null
              ? () {
                  appHaptic();
                  setState(() {
                    isExplained = !isExplained;
                  });
                }
              : widget.onTap,
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.sw, horizontal: 16.sw),
            child: Row(
              children: [
                WidgetAppSVG(
                  widget.asset,
                  width: 20.sw,
                  height: 20.sw,
                  color: appColorText,
                ),
                Gap(12.sw),
                Expanded(
                  child: Text(
                    widget.title,
                    style: w500TextStyle(fontSize: 16.sw),
                  ),
                ),
                if (widget.rightAction != null)
                  widget.rightAction!
                else if (widget.child != null)
                  AnimatedRotation(
                    duration: Durations.medium1,
                    turns: isExplained ? .75 : .5,
                    child: WidgetAppSVG(
                      'chevron-left',
                      width: 20.sw,
                      height: 20.sw,
                      color: appColorText,
                    ),
                  ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: Durations.medium1,
          child: widget.child != null && isExplained
              ? Padding(
                  padding: EdgeInsets.only(top: 8.sw, left: 32.sw),
                  child: widget.child!,
                )
              : SizedBox(
                  width: context.width,
                ),
        )
      ],
    );
  }
}

class _WidgetSection extends StatelessWidget {
  final String title;
  final Widget child;
  const _WidgetSection({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sw),
          child: Text(
            title,
            style: w300TextStyle(fontSize: 12.sw),
          ),
        ),
        Gap(16.sw),
        child,
      ],
    );
  }
}

class _WidgetButtonCheck extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool isSelected;
  const _WidgetButtonCheck({
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
        padding: EdgeInsets.symmetric(vertical: 12.sw, horizontal: 16.sw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: w500TextStyle(
                      fontSize: 14.sw,
                      color: isSelected ? appColorPrimary : appColorText,
                    ),
                  ),
                ),
                Icon(
                  CupertinoIcons.check_mark,
                  color: isSelected ? appColorPrimary : Colors.transparent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
