import 'dart:io';

import 'package:internal_core/internal_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:flutter_portal/flutter_portal.dart';

import 'internal_setup.dart';
import 'src/base/bloc.dart';
import 'src/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    if (Platform.isAndroid)
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.top]),
    if (Platform.isIOS)
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
    AppPrefs.instance.initialize(),
    initEasyLocalization(),
  ]);
  bloc.Bloc.observer = AppBlocObserver();

  internalSetup();
  getItSetup();

    runApp(wrapEasyLocalization(child: const _App()));
   
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return Portal(
      child: MaterialApp.router(
        routerConfig: goRouter,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: AppPrefs.instance.isDarkTheme
            ? ThemeData.dark()
            : ThemeData.light(),
        themeMode:
            AppPrefs.instance.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
        builder: (context, child) {
          return Stack(
            children: [
              child!,
              ValueListenableBuilder(
                valueListenable: loadingProgressIndicator,
                builder: (context, value, child) {
                  if (value == true) return child!;
                  return const SizedBox();
                },
                child: SizedBox(
                  height: 3,
                  child: LinearProgressIndicator(
                    backgroundColor: appColorPrimary.withOpacity(.1),
                    color: appColorPrimary,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

ValueNotifier<bool> loadingProgressIndicator = ValueNotifier(false);
