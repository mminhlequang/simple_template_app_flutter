import 'package:app/src/presentation/widgets/widgets.dart';
import 'package:app/src/utils/utils.dart';
import 'package:internal_core/internal_core.dart';
import 'package:app/src/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import '../cubit/favorite_cubit.dart';
import '../cubit/image_cubit.dart';
import '../cubit/report_cubit.dart';
import 'widget_setting_grid.dart';
import 'widget_image_item.dart';

class WidgetBestCollection extends StatefulWidget {
  const WidgetBestCollection({super.key});

  @override
  State<WidgetBestCollection> createState() => _WidgetBestCollectionState();
}

class _WidgetBestCollectionState extends State<WidgetBestCollection> {
  @override
  void initState() {
    super.initState();
    imageCubit.fetchImages(refresh: true);
  }

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
                        'DreamArt Collection',
                        style: w600TextStyle(fontSize: 18.sw),
                      ),
                      Gap(2.sw),
                      Text(
                        'Best collection created by AI'.tr(),
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
            return BlocBuilder<ImageCubit, ImageState>(
              bloc: imageCubit,
              builder: (context, state) {
                var images = state.imagesDisplay;
                return WidgetLoadMoreCallbackBuilder(
                  callback: () async {
                    await imageCubit.fetchImages(page: imageCubit.page + 1);
                  },
                  heighStartLoad: AppPrefs.instance.isGridView
                      ? context.height / 1.5
                      : context.height,
                  builder:
                      (bool isPerformingRequest, ScrollController controller) {
                    return state.images?.isEmpty == true
                        ? WidgetProblemLoading(
                            callback: () {
                              appHaptic();
                              imageCubit.fetchImages(refresh: true);
                            },
                          )
                        : BlocBuilder<FavoriteCubit, FavoriteState>(
                            bloc: favoriteCubit,
                            builder: (context, state) {
                              if (AppPrefs.instance.isGridView) {
                                return MasonryGridView.count(
                                  addAutomaticKeepAlives: false,
                                  controller: controller,
                                  padding: EdgeInsets.fromLTRB(
                                      horizPadding,
                                      12.sw +
                                          context.mediaQueryPadding.top +
                                          50,
                                      horizPadding,
                                      12.sw),
                                  crossAxisCount: crossAxisCount,
                                  mainAxisSpacing: 8.sw,
                                  crossAxisSpacing: 8.sw,
                                  itemCount: images == null
                                      ? shimmerItemCount
                                      : images.length,
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
                                            isCollectionList: true,
                                          );
                                  },
                                );
                              }
                              return ListView.separated(
                                  controller: controller,
                                  padding: EdgeInsets.fromLTRB(
                                      horizPadding,
                                      12.sw +
                                          context.mediaQueryPadding.top +
                                          50,
                                      horizPadding,
                                      12.sw),
                                  itemBuilder: (_, index) {
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
                                            isCollectionList: true,
                                          );
                                  },
                                  separatorBuilder: (_, index) =>
                                      SizedBox(height: 12.sw),
                                  itemCount: images == null
                                      ? shimmerItemCount
                                      : images.length);
                            },
                          );
                  },
                );
              },
            );
          },
        ),
        Positioned(
          top: context.mediaQueryPadding.top + 8,
          right: horizPadding,
          child: const WidgetSettingGrid(),
        )
      ],
    );
  }
}
