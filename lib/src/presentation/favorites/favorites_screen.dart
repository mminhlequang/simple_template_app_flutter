import 'package:internal_core/internal_core.dart';
import 'package:app/src/constants/constants.dart';
import 'package:app/src/presentation/home/cubit/favorite_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';

import '../home/cubit/report_cubit.dart';
import '../home/widgets/widget_image_item.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
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
                Gap(horizPadding),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your favorites'.tr(),
                        style: w600TextStyle(fontSize: 18.sw),
                      ),
                      Gap(2.sw),
                      Text(
                        'Save impressive photos'.tr(),
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
        BlocBuilder<ReportCubit, ReportState>(
            bloc: reportCubit,
            builder: (context, reportState) {
              return BlocBuilder<FavoriteCubit, FavoriteState>(
                bloc: favoriteCubit,
                builder: (context, state) {
                  var images = state.imagesDisplay;
                  return images?.isEmpty == true
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
                                "We not have yet any\nfavorite images ...".tr(),
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
                          itemCount:
                              images == null ? shimmerItemCount : images.length,
                          itemBuilder: (context, index) {
                            var m = images?[index];
                            return images == null
                                ? AspectRatio(
                                    aspectRatio: images == null
                                        ? doubleInRange(0.6, 1.2)
                                        : m!.ratio,
                                    child: WidgetAppShimmer(
                                      borderRadius:
                                          BorderRadius.circular(12.sw),
                                    ),
                                  )
                                : WidgetImageItem(
                                    index: index,
                                    m: m!,
                                    images: images,
                                    enalbeBlur: false,
                                  );
                          },
                        );
                },
              );
            }),
        // Positioned(
        //   top: context.mediaQueryPadding.top + 8,
        //   right: horizPadding,
        //   child: const WidgetFilters(),
        // )
      ],
    );
  }
}
