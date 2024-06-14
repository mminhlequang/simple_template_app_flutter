import 'package:app/src/utils/utils.dart';
import 'package:internal_core/internal_core.dart';
import 'package:app/src/constants/constants.dart';
import 'package:flutter/material.dart';

class WidgetSettingGrid extends StatelessWidget {
  const WidgetSettingGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetRippleButton(
      onTap: () {
        AppPrefs.instance.isGridView = !AppPrefs.instance.isGridView;
        WidgetsFlutterBinding.ensureInitialized().performReassemble();
      },
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12.sw),
      child: WidgetGlassBackground(
        backgroundColor: Colors.black12,
        borderRadius: BorderRadius.circular(12.sw),
        padding: EdgeInsets.symmetric(vertical: 6.sw, horizontal: 8.sw),
        child: Row(
          children: [
            WidgetAppSVG(
              "grid-2-horizontal",
              width: 20.sw,
              color: Colors.white
                  .withOpacity(AppPrefs.instance.isGridView ? .4 : 1),
            ),
            Container(
              width: 1,
              height: 16,
              color: Colors.white.withOpacity(.2),
              margin: EdgeInsets.symmetric(horizontal: 4.sw),
            ),
            WidgetAppSVG(
              "grid-4",
              width: 20.sw,
              color: Colors.white
                  .withOpacity(!AppPrefs.instance.isGridView ? .4 : 1),
            ),
          ],
        ),
      ),
    );
  }
}
