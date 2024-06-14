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

import '../home/cubit/favorite_model_cubit.dart';
import '../home/cubit/model_cubit.dart';
import '../widgets/widgets.dart';
import 'widgets/widget_filters.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  void initState() {
    super.initState();
    if (modelCubit.state.models?.isNotEmpty != true) {
      modelCubit.fetchModels(refresh: true);
    }
  }

  bool isOnlyFavorited = false;

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
        BlocBuilder<FavoriteModelCubit, FavoriteModelState>(
            bloc: favoriteModelCubit,
            builder: (context, stateFavoriteModel) {
              return BlocBuilder<ModelCubit, ModelState>(
                bloc: modelCubit,
                builder: (context, state) {
                  var items = state.models
                      ?.where((e) => isOnlyFavorited
                          ? stateFavoriteModel.images?.contains(e.id) == true
                          : true)
                      .toList();
                  return items?.isEmpty == true
                      ? WidgetProblemLoading(
                          callback: () {
                            appHaptic();
                            modelCubit.fetchModels(refresh: true);
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
                          itemCount:
                              items == null ? shimmerItemCount : items.length,
                          itemBuilder: (context, index) {
                            return items == null
                                ? AspectRatio(
                                    aspectRatio: doubleInRange(0.6, 1.2),
                                    child: WidgetAppShimmer(
                                      borderRadius:
                                          BorderRadius.circular(12.sw),
                                    ),
                                  )
                                : _WidgetImage(
                                    imageUrl: (items[index]).sfwImage?.url,
                                    index: index,
                                    m: items[index],
                                  );
                          },
                        );
                },
              );
            }),
        Positioned(
          top: context.mediaQueryPadding.top + 8,
          right: horizPadding,
          child: Row(
            children: [
              WidgetFloatIconButton(
                onTap: () {
                  appHaptic();
                  setState(() {
                    isOnlyFavorited = !isOnlyFavorited;
                  });
                },
                isSmallSize: false,
                icon: 'bx-bookmark-heart',
                color: isOnlyFavorited ? appColorPrimary : Colors.white,
              ),
              Gap(16.sw),
              const WidgetFilters(),
            ],
          ),
        ),
      ],
    );
  }
}

class _WidgetImage extends StatelessWidget {
  final String? imageUrl;
  final CivitaiModel m;
  final int index;
  const _WidgetImage(
      {super.key, this.imageUrl, required this.m, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        appHaptic();
        if (m.nsfw == true && AppPrefs.instance.nsfw == "None") {
          var r = await nsfwWarningDialog();
          if (r != true) return;
        }
        modelCubit.selectModel(m);
        await showInterstitialAd();
        context.push('/image_by_model');
      },
      child: WidgetAppImage(
        imageUrl: imageUrl,
        radius: 12.sw,
        maxWidthCache: context.width ~/ 1.5,
        memCacheWidth: context.width ~/ 1.5,
        errorWidget: const SizedBox(),
        imageBuilder: (context, child) => Stack(
          alignment: Alignment.bottomCenter,
          children: [
            child,
            Container(
              width: context.width,
              height: 80.sw,
              padding: EdgeInsets.symmetric(horizontal: 16.sw),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(.85),
                      Colors.black.withOpacity(.55),
                      Colors.black.withOpacity(.00001)
                    ]),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    m.name ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: w500TextStyle(fontSize: 14.sw, color: Colors.white),
                  ),
                  Gap(2.sw),
                  Row(
                    children: [
                      Text(
                        "👏 ",
                        style: TextStyle(
                          fontSize: 12.sw,
                        ),
                      ),
                      Text(
                        m.stats?.downloadCount?.toString() ?? "-",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            w500TextStyle(fontSize: 12.sw, color: Colors.white),
                      ),
                      Text(
                        "   👍 ",
                        style: TextStyle(
                          fontSize: 12.sw,
                        ),
                      ),
                      Text(
                        m.stats?.thumbsUpCount?.toString() ?? "-",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            w500TextStyle(fontSize: 12.sw, color: Colors.white),
                      ),
                    ],
                  ),
                  Gap(8.sw),
                ],
              ),
            ),
            if (m.nsfw == true)
              const Positioned(
                top: 8,
                left: 8,
                child: WidgetAppSVG(
                  'nsfw1',
                  width: 28,
                ),
              ),
            Positioned(
              top: 8.sw,
              right: horizPadding,
              child: BlocBuilder<FavoriteModelCubit, FavoriteModelState>(
                bloc: favoriteModelCubit,
                builder: (context, state) {
                  return WidgetFloatIconButton(
                    onTap: () {
                      appHaptic();
                      if (state.isFavorited(m.id!)) {
                        favoriteModelCubit.removeToFavorite(m.id!);
                      } else {
                        favoriteModelCubit.addToFavorite(m.id!);
                      }
                    },
                    icon: 'bx-bookmark-heart',
                    color: state.isFavorited(m.id!)
                        ? appColorPrimary
                        : Colors.white,
                  );
                },
              ),
            ),
          ],
        ),
        placeholderWidget: AspectRatio(
          aspectRatio: doubleInRange(0.6, 1.2),
          child: WidgetAppShimmer(
            borderRadius: BorderRadius.circular(12.sw),
          ),
        ),
      ),
    );
  }
}
