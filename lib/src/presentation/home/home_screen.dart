import 'dart:async';
import 'dart:io';

import 'package:app/src/constants/constants.dart';
import 'package:app/src/presentation/home/widgets/best_collection.dart';
import 'package:app/src/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:gap/gap.dart';
import 'package:internal_core/internal_core.dart';
import 'package:flutter/material.dart';

import '../explore/explore_screen.dart';
import '../favorites/favorites_screen.dart';
import '../settings/settings_screen.dart';
import 'cubit/favorite_cubit.dart';
import 'cubit/favorite_model_cubit.dart';
import 'cubit/model_cubit.dart';
import 'cubit/report_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int indexSelected = 0;
  @override
  void initState() {
    super.initState();
    modelCubit.fetchTags();
    reportCubit.fetchReports();
    favoriteCubit.fetchFavorites();
    favoriteModelCubit.fetchFavorites();
    modelCubit.fetchModels(refresh: true);
    
  }
 

  // Future<void> showCustomTrackingDialog() async =>
  //     await showCupertinoDialog<void>(
  //       context: appContext,
  //       builder: (context) => CupertinoAlertDialog(
  //         title: Text(
  //           'Privacy and data security\n'.tr(),
  //           style: w500TextStyle(fontSize: 16.sw, height: 1.4),
  //         ),
  //         content: Text(
  //           'We care about your privacy and data security. We keep this app free by showing ads. \nCan we continue to use your data to tailor ads for you?\n\nYou can change your choice anytime in the app settings. \nOur partners will collect data and use a unique identifier on your device to show you ads.'
  //               .tr(),
  //           style: w400TextStyle(
  //               fontSize: 15.sw,
  //               height: 1.4,
  //               color: appColorText.withOpacity(.8)),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: Text(
  //               'Continue'.tr(),
  //               style: w500TextStyle(fontSize: 16.sw, height: 1.4),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: appColorBackground,
          bottomNavigationBar: _WidgetBottomNavBar(
            indexSelected: indexSelected,
            indexChanged: (value) {
              setState(() {
                indexSelected = value;
              });
            },
          ),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: [
              const WidgetBestCollection(),
              const ExploreScreen(),
              const FavoritesScreen(),
              const SettingsScreen()
            ][indexSelected],
          ),
        );
      },
    );
  }
}

class _WidgetBottomNavBar extends StatelessWidget {
  final int indexSelected;
  final ValueChanged indexChanged;
  const _WidgetBottomNavBar({
    super.key,
    required this.indexSelected,
    required this.indexChanged,
  });

  Widget get child => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(),
          _buildItem("livephoto", "Home", 0),
          if (AppPrefs.instance.enableNsfw || !Platform.isAndroid || kDebugMode)
            _buildItem("layout", "Explore", 1),
          _buildItem("like", "Favorite", 2),
          _buildItem("settings", "Setting", 3),
          const SizedBox(),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return WidgetAnimationStaggeredItem(
      type: AnimationStaggeredType.bottomToTop,
      index: 1,
      child: Container(
        height: 60.sw + context.mediaQueryPadding.bottom,
        padding: EdgeInsets.only(
            left: 12.sw,
            right: 12.sw,
            bottom: context.mediaQueryPadding.bottom),
        decoration: BoxDecoration(
          color: appColorBackground,
          boxShadow: [
            BoxShadow(
                color: byTheme(appColorText.withOpacity(.15),
                    kdark: Colors.black45),
                blurRadius: 99.sw,
                offset: const Offset(0, -4))
          ],
        ),
        child: appContext.width > 620
            ? Row(
                children: [
                  const Spacer(),
                  SizedBox(
                    width: 620,
                    child: child,
                  ),
                  const Spacer(),
                ],
              )
            : child,
      ),
    );
  }

  Widget _buildItem(asset, text, index) {
    return WidgetRippleButton(
      onTap: () {
        appHaptic();
        indexChanged(index);
      },
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(99),
      child: Container(
        height: 60.sw,
        padding: EdgeInsets.symmetric(horizontal: 20.sw, vertical: 4.sw),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(2.sw),
              WidgetAppSVG(
                asset,
                width: 24.sw,
                color:
                    appColorText.withOpacity(index == indexSelected ? 1 : .4),
              ),
              Gap(1.sw),
              Text(
                text,
                style: index == indexSelected
                    ? w400TextStyle(fontSize: 12.sw, color: appColorText)
                    : w300TextStyle(
                        fontSize: 12.sw, color: appColorText.withOpacity(.4)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
