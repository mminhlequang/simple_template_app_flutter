import 'dart:io';

import 'package:app/src/constants/constants.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:internal_core/internal_core.dart';
import 'package:app/main.dart';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:path/path.dart' as path;

import 'utils.dart';

Future<bool?> nsfwWarningDialog() async => await showCupertinoDialog<bool>(
      context: appContext,
      builder: (context) => CupertinoAlertDialog(
        title: Text(
          'NSFW content is intended for users over 18 years of age only\n'.tr(),
          style: w500TextStyle(fontSize: 16.sw, height: 1.4),
        ),
        content: Text(
          'Please confirm that you are of age and accept full responsibility for continuing'
              .tr(),
          style: w400TextStyle(
              fontSize: 15.sw,
              height: 1.4,
              color: appColorText.withOpacity(.8)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel'.tr(),
              style: w500TextStyle(fontSize: 16.sw, height: 1.4),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Yes'.tr(),
              style: w500TextStyle(fontSize: 16.sw, height: 1.4),
            ),
          ),
        ],
      ),
    );

bool get isMobile => Platform.isIOS || Platform.isAndroid;

String stringShareImage(url) =>
    '"DreamArt Collection"\n${"I want share to you this image:".tr()} $url\n${"You can view more at:".tr()} ${Platform.isAndroid ? "https://play.google.com/store/apps/details?id=com.mminhlequang.dreamartai2" : "https://apps.apple.com/us/app/dreamart-ai/id6480363700?platform=iphone"}';

setWallpaper(url, int wallpaperLocation) async {
  appDebugPrint('[setWallpaper] url=$url');
  appHaptic();
  String result;
  loadingProgressIndicator.value = true;
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    result = await AsyncWallpaper.setWallpaper(
      url: url,
      wallpaperLocation: wallpaperLocation,
      goToHome: true,
      toastDetails: ToastDetails.success(),
      errorToastDetails: ToastDetails.error(),
    )
        ? 'Wallpaper set'.tr()
        : 'Failed to get wallpaper.'.tr();
  } on PlatformException {
    result = 'Failed to get wallpaper.';
  }
  loadingProgressIndicator.value = false;
  appDebugPrint('[setWallpaper] $result');
  showInterstitialAd();
}

saveNetworkImage(String url) async {
  loadingProgressIndicator.value = true;
  appDebugPrint('[saveNetworkImage] $url');

  if (isMobile) {
    var response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));

    //{"isSuccess":true, "filePath":String?}
    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 100,
      name: path.basenameWithoutExtension(url),
    );

    loadingProgressIndicator.value = false;
    appDebugPrint('[saveNetworkImage] ${result.runtimeType} result=$result');
    showSnackBar(
        msg: result['isSuccess'] == true
            ? "Save image succusfully!".tr()
            : "Failed to save image!".tr());
    showInterstitialAd();
  } else {
    String result = await FileSaver.instance.saveFile(
      name: path.basenameWithoutExtension(url),
      link: LinkDetails(link: url),
      ext: url.split(".").last,
    );

    loadingProgressIndicator.value = false;
    appDebugPrint('[saveNetworkImage] ${result.runtimeType} result=$result');
    showSnackBar(msg: "Save image succusfully!".tr());
  }
}

onOpenImage({
  bool isExploreList = false,
  bool isCollectionList = false,
  required images,
  required index,
}) async {
  appHaptic();
  await showInterstitialAd();
  appContext.push(
    '/image_view',
    extra: {
      "images": images,
      "index": index,
      "isExploreList": isExploreList,
      "isCollectionList": isCollectionList,
    },
  );
}

bool appIsBottomSheetOpen = false;
appOpenBottomSheet(
  Widget child, {
  bool isDismissible = true,
  bool enableDrag = true,
}) async {
  appIsBottomSheetOpen = true;
  var r = await showMaterialModalBottomSheet(
    enableDrag: enableDrag,
    context: appContext,
    builder: (_) => Padding(
      padding: MediaQuery.viewInsetsOf(_),
      child: child,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    isDismissible: isDismissible,
    backgroundColor: appColorBackground,
    useRootNavigator: true,
  );
  appIsBottomSheetOpen = false;
  return r;
}

bool appIsDialogOpen = false;
appDialog(Widget child, {bool barrierDismissible = true}) async {
  appIsDialogOpen = true;
  var r = await showGeneralDialog(
    barrierLabel: "popup",
    barrierColor: Colors.black.withOpacity(.5),
    barrierDismissible: barrierDismissible,
    transitionDuration: const Duration(milliseconds: 300),
    context: appContext,
    pageBuilder: (context, anim1, anim2) {
      return child;
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
            .animate(anim1),
        child: child,
      );
    },
  );
  appIsDialogOpen = false;
  return r;
}

appChangedTheme() {
  AppPrefs.instance.isDarkTheme = !AppPrefs.instance.isDarkTheme;
  WidgetsFlutterBinding.ensureInitialized().performReassemble();
}

enum AppSnackBarType { error, success, notitfication }

showSnackBar({context, required msg, Duration? duration}) {
  ScaffoldMessenger.of(context ?? appContext).showSnackBar(
    SnackBar(
      content: Text(
        msg,
        style: w300TextStyle(color: appColorBackground),
      ),
      duration: duration ?? const Duration(seconds: 1),
      backgroundColor: appColorText,
    ),
  );
}

appSentryCaptureMessage({required where, required msg}) {
  Sentry.captureMessage(
    '[$where] $msg',
  );
}
