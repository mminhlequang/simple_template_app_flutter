import 'dart:math';

import 'package:app/src/constants/app_colors.dart';
import 'package:internal_core/internal_core.dart';
import 'package:flutter/material.dart';

class WidgetPopupContainer extends StatelessWidget {
  final Widget child;
  final Alignment? alignmentTail;
  final EdgeInsets? paddingTail;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  const WidgetPopupContainer({
    super.key,
    required this.child,
    this.alignmentTail,
    this.paddingTail,
    this.borderRadius,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: alignmentTail ?? Alignment.topRight,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          width: width,
          height: height,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: byTheme(appColorText.withOpacity(.1),
                    kdark: Colors.black45),
                blurRadius: 12)
          ], color: appColorElement, borderRadius: BorderRadius.circular(16)),
          child: child,
        ),
        Padding(
          padding: paddingTail ?? const EdgeInsets.only(right: 28),
          child: Transform.rotate(
            angle: pi / 4,
            child: Container(
              height: 16,
              width: 16,
              color: appColorElement,
            ),
          ),
        )
      ],
    );
  }
}
