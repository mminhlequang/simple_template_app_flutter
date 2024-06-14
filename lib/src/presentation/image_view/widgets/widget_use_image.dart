import 'dart:io';

import 'package:internal_core/internal_core.dart';
import 'package:app/src/constants/app_sizes.dart';
import 'package:app/src/network_resources/civitai/model/model.dart';
import 'package:app/src/presentation/home/widgets/widget_prompt_image.dart';
import 'package:app/src/utils/utils.dart';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class WidgetUseImage extends StatelessWidget {
  final String url;
  final CivitaiImage m;
  const WidgetUseImage({super.key, required this.url, required this.m});

  bool get isEnableSetWallpaper => Platform.isAndroid;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.sw),
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
                  color: appColorText.withOpacity(.1),
                  borderRadius: BorderRadius.circular(99)),
            ),
          ),
          SizedBox(
            height: 12.sw,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sw),
            child: Text(
              "What would like to do?".tr(),
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
          _WidgetButton(
            asset: 'slideshow',
            title: 'Set Wallpaper',
            isEnableSetWallpaper: isEnableSetWallpaper,
            onTap: () {
              context.pop();
              if (isEnableSetWallpaper) {
                setWallpaper(url, AsyncWallpaper.HOME_SCREEN);
              }
            },
          ),
          _WidgetButton(
            asset: 'lock-access',
            title: 'Set Lock Screen',
            isEnableSetWallpaper: isEnableSetWallpaper,
            onTap: () {
              context.pop();
              if (isEnableSetWallpaper) {
                setWallpaper(url, AsyncWallpaper.LOCK_SCREEN);
              }
            },
          ),
          _WidgetButton(
            asset: 'devices',
            title: 'Set Both',
            isEnableSetWallpaper: isEnableSetWallpaper,
            onTap: () {
              context.pop();
              if (isEnableSetWallpaper) {
                setWallpaper(url, AsyncWallpaper.BOTH_SCREENS);
              }
            },
          ),
          _WidgetButton(
            asset: 'share',
            title: 'Share this image',
            onTap: () {
              context.pop();
              appHaptic();
              final box = context.findRenderObject() as RenderBox?;
              Share.share(
                stringShareImage(m.url),
                subject: 'Share to you this image',
                sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
              );
            },
          ),
          _WidgetButton(
            asset: 'info-square',
            title: 'Meta image',
            onTap: () {
              context.pop();
              appHaptic();
              appOpenBottomSheet(WidgetPromptImage(m: m));
            },
          ),
          SizedBox(
            height: 12.sw,
          ),
        ],
      ),
    );
  }
}

class _WidgetButton extends StatelessWidget {
  final String asset;
  final String title;
  final VoidCallback? onTap;
  final bool isEnableSetWallpaper;
  const _WidgetButton({
    super.key,
    required this.title,
    required this.asset,
    this.onTap,
    this.isEnableSetWallpaper = true,
  });

  @override
  Widget build(BuildContext context) {
    return WidgetRippleButton(
      onTap: onTap,
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.sw, horizontal: 16.sw),
        child: Opacity(
          opacity: isEnableSetWallpaper ? 1 : .45,
          child: Row(
            children: [
              WidgetAppSVG(
                asset,
                width: 20.sw,
                height: 20.sw,
                color: appColorText,
              ),
              Gap(12.sw),
              Expanded(
                child: Text(
                  title,
                  style: w500TextStyle(fontSize: 16.sw),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
