import 'package:flutter/widgets.dart';

class WidgetLoadMoreCallbackBuilder extends StatefulWidget {
  final Function callback;
  final Widget Function(bool isPerformingRequest, ScrollController controller)
      builder;
  final bool alsoSetState;
  final double? heighStartLoad;
  const WidgetLoadMoreCallbackBuilder({
    super.key,
    required this.callback,
    required this.builder,
    this.alsoSetState = false,
    this.heighStartLoad,
  });

  @override
  State<WidgetLoadMoreCallbackBuilder> createState() =>
      _WidgetLoadMoreCallbackBuilderState();
}

class _WidgetLoadMoreCallbackBuilderState
    extends State<WidgetLoadMoreCallbackBuilder> {
  bool isPerformingRequest = false;
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent -
              (widget.heighStartLoad ??
                  MediaQuery.of(context).size.height / 2)) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _loadMore() async {
    if (mounted && !isPerformingRequest) {
      isPerformingRequest = true;
      if (widget.alsoSetState) setState(() {});
      await widget.callback();
      isPerformingRequest = false;
      if (mounted && widget.alsoSetState) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(isPerformingRequest, _controller);
  }
}
