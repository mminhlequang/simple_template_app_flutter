import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'DreamArt Collection',
      home: _WebScreen(),
    );
  }
}

class _WebScreen extends StatelessWidget {
  const _WebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 260,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    launchUrlString(
                      "https://play.google.com/store/apps/details?id=com.mminhlequang.dreamartai2",
                      webOnlyWindowName: '_self',
                    );
                  },
                  child: Image.asset(
                    'assets/images/googleplay.png',
                    width: 140,
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    launchUrlString(
                      "https://apps.apple.com/us/app/dreamart-ai/id6480363700?platform=iphone",
                      webOnlyWindowName: '_self',
                    );
                  },
                  child: Image.asset(
                    'assets/images/appstore.png',
                    width: 140,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
