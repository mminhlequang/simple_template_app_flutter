import 'dart:typed_data';

import 'package:app/src/presentation/widgets/widgets.dart';
import 'package:blurhash/blurhash.dart';
import 'package:internal_core/internal_core.dart';
import 'package:app/src/constants/constants.dart';
import 'package:app/src/network_resources/civitai/model/model.dart';
import 'package:app/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../cubit/favorite_cubit.dart';
import '../cubit/report_cubit.dart';
import 'widget_prompt_image.dart';
import 'widget_report_image.dart';

class WidgetImageItem extends StatefulWidget {
  final CivitaiImage m;
  final List<CivitaiImage>? images;
  final int index;
  final bool enalbeBlur;
  final bool isReportList;
  final bool isExploreList;
  final bool isCollectionList;
  const WidgetImageItem({
    super.key,
    required this.m,
    required this.index,
    required this.images,
    this.enalbeBlur = true,
    this.isCollectionList = false,
    this.isReportList = false,
    this.isExploreList = false,
  });

  @override
  State<WidgetImageItem> createState() => _WidgetImageItemState();
}

class _WidgetImageItemState extends State<WidgetImageItem> {
  @override
  void initState() {
    super.initState();
    if (!isDisplay) {
      blurHashDecode();
    }
  }

  late bool isDisplay = !widget.enalbeBlur ||
      !(isMobile) ||
      !AppPrefs.instance.blurNsfwImage ||
      widget.m.nsfwLevel == "None";

  Uint8List? imageDataBytes;
  void blurHashDecode() async {
    imageDataBytes;
    try {
      imageDataBytes = await BlurHash.decode(widget.m.hash ?? "", 20, 12);
      if (mounted) setState(() {});
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isDisplay) {
          isDisplay = true;
          setState(() {});
        } else {
          onOpenImage(
            isExploreList: widget.isExploreList,
            isCollectionList: widget.isCollectionList,
            images: widget.images ?? <CivitaiImage>[],
            index: widget.index,
          );
        }
      },
      child: Hero(
        tag: widget.m.url!,
        child: WidgetAppImage(
          imageUrl: widget.m.url,
          radius: 12.sw,
          maxWidthCache:
              (context.width * 1.2 / (AppPrefs.instance.isGridView ? 2 : 1))
                  .toInt(),
          memCacheWidth:
              (context.width * 1.2 / (AppPrefs.instance.isGridView ? 2 : 1))
                  .toInt(),
          errorBuilder: (context, error, stackTrace) {
            if (!reportCubit.state.isReported(widget.m)) {
              reportCubit.addToReport(widget.m);
            }
            return const SizedBox();
          },
          imageBuilder: (context, child) => AspectRatio(
            aspectRatio: widget.m.ratio,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                if (isDisplay) Positioned.fill(child: child),
                if (AppPrefs.instance.enablePormpt)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: WidgetFloatIconButton(
                      onTap: () {
                        appHaptic();
                        appOpenBottomSheet(WidgetPromptImage(m: widget.m));
                      },
                      icon: 'info-square',
                      color: Colors.white,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      WidgetFloatIconButton(
                        onTap: () {
                          appHaptic();
                        },
                        icon: 'cloud-download',
                        color: Colors.white,
                      ),
                      const Spacer(),
                      WidgetFloatIconButton(
                        onTap: () {
                          appHaptic();
                          if (!widget.isReportList) {
                            appOpenBottomSheet(WidgetReportImage(m: widget.m));
                          } else {
                            reportCubit.removeToReport(widget.m);
                          }
                        },
                        icon: 'eye-off',
                        color: widget.isReportList
                            ? appColorPrimary
                            : Colors.white,
                      ),
                      const Gap(4),
                      WidgetFloatIconButton(
                        onTap: () {
                          appHaptic();
                          if (favoriteCubit.state.isFavorited(widget.m)) {
                            favoriteCubit.removeToFavorite(widget.m);
                          } else {
                            favoriteCubit.addToFavorite(widget.m);
                          }
                        },
                        icon: 'like',
                        color: favoriteCubit.state.isFavorited(widget.m)
                            ? appColorPrimary
                            : Colors.white,
                      )
                    ],
                  ),
                ),
                if (!isDisplay && imageDataBytes != null)
                  Positioned.fill(
                    child: Image.memory(
                      imageDataBytes!,
                      fit: BoxFit.cover,
                    ),
                  ),
                if (widget.m.nsfwLevel != "None")
                  const Positioned(
                    top: 8,
                    left: 8,
                    child: WidgetAppSVG(
                      'nsfw1',
                      width: 28,
                    ),
                  ),
              ],
            ),
          ),
          placeholderWidget: AspectRatio(
            aspectRatio: widget.m.ratio,
            child: WidgetAppShimmer(
              borderRadius: BorderRadius.circular(12.sw),
            ),
          ),
        ),
      ),
    );
  }
}
