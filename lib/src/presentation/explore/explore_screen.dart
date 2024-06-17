import 'package:internal_core/internal_core.dart';
import 'package:app/src/constants/constants.dart';
import 'package:app/src/network_resources/civitai/model/model.dart';
import 'package:app/src/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../home/widgets/widget_card_item.dart';
import '../widgets/widgets.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  void initState() {
    super.initState();
  }

  var items = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Column(
          children: [
            Gap(context.mediaQueryPadding.top + 8),
            Row(
              children: [
                Gap(16.sw),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Explore gallery images'.tr(),
                        style: w600TextStyle(fontSize: 18.sw),
                      ),
                      Gap(2.sw),
                      Text(
                        'Highest Rated Models AI'.tr(),
                        style: w300TextStyle(fontSize: 12.sw),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(4.sw),
          ],
        ),
        items?.isEmpty == true
            ? WidgetProblemLoading(
                callback: () {
                  appHaptic();
                },
              )
            : MasonryGridView.count(
                addAutomaticKeepAlives: false,
                padding: EdgeInsets.fromLTRB(
                    horizPadding,
                    12.sw + context.mediaQueryPadding.top + 50,
                    horizPadding,
                    12.sw),
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 8.sw,
                crossAxisSpacing: 8.sw,
                itemCount: items == null ? shimmerItemCount : items.length,
                itemBuilder: (context, index) {
                  return items == null
                      ? AspectRatio(
                          aspectRatio: doubleInRange(0.6, 1.2),
                          child: WidgetAppShimmer(
                            borderRadius: BorderRadius.circular(12.sw),
                          ),
                        )
                      : WidgetCardItem(
                          index: index,
                        );
                },
              ),
      ],
    );
  }
}
