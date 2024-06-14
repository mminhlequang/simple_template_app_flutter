import 'package:flutter/cupertino.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:internal_core/internal_core.dart';

class WidgetAppSwitcher extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onToggle;
  const WidgetAppSwitcher(
      {super.key, required this.value, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: 42,
      height: 22,
      toggleSize: 16,
      activeColor: appColorText.withOpacity(.2),
      inactiveColor: appColorText.withOpacity(.2),
      toggleColor: appColorBackground,
      inactiveToggleColor: appColorText.withOpacity(.25),
      activeText: '',
      inactiveText: '',
      value: value,
      borderRadius: 15,
      padding: 3,
      showOnOff: true,
      onToggle: onToggle,
    );
  }
}
