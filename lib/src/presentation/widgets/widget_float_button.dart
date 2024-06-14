import 'package:app/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:internal_core/internal_core.dart';

class WidgetFloatButtonBack extends StatelessWidget {
  final dynamic result;
  const WidgetFloatButtonBack({super.key, this.result});

  @override
  Widget build(BuildContext context) {
    return WidgetFloatIconButton(
      onTap: () {
        appHaptic();
        context.pop(result);
      },
      isSmallSize: false,
      icon: 'chevron-left',
      color: Colors.white,
    );
  }
}

class WidgetFloatIconButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color color;
  final bool isSmallSize;
  final String icon;
  final EdgeInsets? padding;
  const WidgetFloatIconButton({
    super.key,
    this.onTap,
    required this.color,
    this.isSmallSize = true,
    required this.icon, this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return WidgetRippleButton(
      onTap: onTap,
      borderRadius: BorderRadius.circular(99),
      color: Colors.transparent,
      child: WidgetGlassBackground(
        backgroundColor: Colors.black12,
        borderRadius: BorderRadius.circular(99),
        padding: padding ?? EdgeInsets.all(8.sw),
        child: WidgetAppSVG(
          icon,
          width: isSmallSize ? 18.sw : 24.sw,
          color: color,
        ),
      ),
    );
  }
}
