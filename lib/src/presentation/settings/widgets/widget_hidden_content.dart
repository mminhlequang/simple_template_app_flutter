import 'package:app/src/presentation/widgets/widgets.dart';
import 'package:internal_core/internal_core.dart';
import 'package:app/src/constants/constants.dart';
import 'package:app/src/presentation/home/cubit/report_cubit.dart';
import 'package:app/src/presentation/home/widgets/widget_image_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';

class WidgetHiddenContent extends StatefulWidget {
  const WidgetHiddenContent({super.key});

  @override
  State<WidgetHiddenContent> createState() => _WidgetHiddenContentState();
}

class _WidgetHiddenContentState extends State<WidgetHiddenContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          Column(
            children: [
              Gap(context.mediaQueryPadding.top + 8),
              Row(
                children: [
                  Gap(horizPadding + 24.sw + 20.sw),
                  Gap(4.sw),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hidden content".tr(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: w600TextStyle(fontSize: 18.sw),
                        ),
                        Gap(4.sw),
                        Row(
                          children: [
                            Text(
                              "You can unhide something here!",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: w500TextStyle(fontSize: 12.sw),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(4.sw),
            ],
          ),
          BlocBuilder<ReportCubit, ReportState>(
            bloc: reportCubit,
            builder: (context, state) {
              return state.images?.isEmpty == true
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          WidgetAppSVG(
                            'empty',
                            width: 40.sw,
                            color: appColorText.withOpacity(.5),
                          ),
                          Gap(8.sw),
                          Text(
                            "We not have yet any\nreport images ...".tr(),
                            textAlign: TextAlign.center,
                            style: w400TextStyle(
                              fontSize: 16.sw,
                              color: appColorText.withOpacity(.5),
                            ),
                          )
                        ],
                      ),
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
                      itemCount: state.images == null
                          ? shimmerItemCount
                          : state.images?.length ?? 0,
                      itemBuilder: (context, index) {
                        var m = state.images?[index];
                        return state.images == null
                            ? AspectRatio(
                                aspectRatio: state.images == null
                                    ? doubleInRange(0.6, 1.2)
                                    : m!.ratio,
                                child: WidgetAppShimmer(
                                  borderRadius: BorderRadius.circular(12.sw),
                                ),
                              )
                            : WidgetImageItem(
                                index: index,
                                m: m!,
                                images: state.images,
                                isReportList: true,
                              );
                      },
                    );
            },
          ),
          Positioned(
            top: 8.sw + context.mediaQueryPadding.top,
            left: horizPadding,
            child: const WidgetFloatButtonBack(),
          ),
        ],
      ),
    );
  }
}
