import 'package:flutter/material.dart';

class WidgetCardItem extends StatefulWidget {
  final int index;
  const WidgetCardItem({super.key, required this.index});

  @override
  State<WidgetCardItem> createState() => _WidgetCardItemState();
}

class _WidgetCardItemState extends State<WidgetCardItem> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
