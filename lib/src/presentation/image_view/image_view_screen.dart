import 'package:app/src/presentation/home/cubit/model_cubit.dart';
import 'package:app/src/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:internal_core/internal_core.dart';
import 'package:app/src/constants/constants.dart';
import 'package:app/src/network_resources/civitai/model/model.dart';
import 'package:app/src/presentation/image_view/widgets/widget_use_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';

import '../home/cubit/favorite_cubit.dart';
import '../home/cubit/image_cubit.dart';
import '../home/cubit/report_cubit.dart';
import '../widgets/widgets.dart';

class ImageViewExploreScreen extends StatefulWidget {
  final int index;
  const ImageViewExploreScreen({super.key, required this.index});

  @override
  State<ImageViewExploreScreen> createState() => _ImageViewExploreScreenState();
}

class _ImageViewExploreScreenState extends State<ImageViewExploreScreen> {
  late CarouselController carouselController = CarouselController();
  List<CivitaiImage> get images => modelCubit.state.imagesDisplay ?? [];
  late int index = widget.index;

  CivitaiImage get m => images.length > index ? images[index] : CivitaiImage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorBackground,
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            BlocBuilder<ReportCubit, ReportState>(
              bloc: reportCubit,
              builder: (context, reportState) {
                return BlocBuilder<ModelCubit, ModelState>(
                  bloc: modelCubit,
                  builder: (context, state) {
                    var images = state.imagesDisplay;

                    return images?.isNotEmpty != true
                        ? const SizedBox()
                        : CarouselSlider.builder(
                            carouselController: carouselController,
                            itemCount: images!.length,
                            itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) {
                              var m = images[itemIndex];

                              return Hero(
                                tag: m.url!,
                                child: ClipRRect(
                                  child: PhotoView(
                                    initialScale:
                                        PhotoViewComputedScale.covered,
                                    backgroundDecoration: const BoxDecoration(
                                        color: Colors.transparent),
                                    imageProvider:
                                        CachedNetworkImageProvider(m.url!),
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              height: context.height,
                              aspectRatio: context.height / context.width,
                              viewportFraction: 1,
                              initialPage: index,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: false,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.25,
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (index, reason) {
                                if (reason !=
                                    CarouselPageChangedReason.controller) {
                                  setState(() {
                                    this.index = index;
                                  });
                                }
                                if (index > images.length - 6) {
                                  modelCubit.fetchImages(
                                      page: modelCubit.page + 1);
                                }
                              },
                            ),
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
            Positioned(
              top: 8.sw + context.mediaQueryPadding.top,
              right: horizPadding,
              child: WidgetFloatIconButton(
                onTap: () {
                  appHaptic();
                  saveNetworkImage(images[index].url!);
                },
                isSmallSize: false,
                icon: 'cloud-download',
                color: Colors.white,
              ),
            ),
            Positioned(
              bottom: context.mediaQueryPadding.bottom,
              left: 12.sw,
              right: 12.sw,
              height: 110.sw - context.mediaQueryPadding.bottom,
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WidgetFloatIconButton(
                      onTap: () {
                        appHaptic();
                        final box = context.findRenderObject() as RenderBox?;
                        Share.share(
                          stringShareImage(m.url),
                          subject: 'Share to you this image',
                          sharePositionOrigin:
                              box!.localToGlobal(Offset.zero) & box.size,
                        );
                      },
                      color: Colors.white,
                      icon: 'share',
                      isSmallSize: false,
                      padding: EdgeInsets.all(12.sw),
                    ),
                    IconButton(
                      onPressed: () {
                        appHaptic();
                        appOpenBottomSheet(WidgetUseImage(m: m, url: m.url!));
                      },
                      color: appColorPrimary,
                      icon: CircleAvatar(
                        backgroundColor: appColorPrimary,
                        radius: 36.sw,
                        child: WidgetAppSVG(
                          'slideshow',
                          width: 32.sw,
                          color: Colors.white,
                        ),
                      ),
                      iconSize: 32.sw,
                    ),
                    BlocBuilder<FavoriteCubit, FavoriteState>(
                      bloc: favoriteCubit,
                      builder: (context, state) {
                        return WidgetFloatIconButton(
                          onTap: () {
                            appHaptic();
                            if (state.isFavorited(m)) {
                              favoriteCubit.removeToFavorite(m);
                            } else {
                              favoriteCubit.addToFavorite(m);
                            }
                          },
                          icon: 'like',
                          color: state.isFavorited(m)
                              ? appColorPrimary
                              : Colors.white,
                          isSmallSize: false,
                          padding: EdgeInsets.all(12.sw),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageViewCollectionScreen extends StatefulWidget {
  final int index;
  const ImageViewCollectionScreen({super.key, required this.index});

  @override
  State<ImageViewCollectionScreen> createState() =>
      _ImageViewCollectionScreenState();
}

class _ImageViewCollectionScreenState extends State<ImageViewCollectionScreen> {
  late CarouselController carouselController = CarouselController();
  List<CivitaiImage> get images => imageCubit.state.imagesDisplay ?? [];
  late int index = widget.index;

  CivitaiImage get m => images.length > index ? images[index] : CivitaiImage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorBackground,
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            BlocBuilder<ReportCubit, ReportState>(
              bloc: reportCubit,
              builder: (context, reportState) {
                return BlocBuilder<ImageCubit, ImageState>(
                  bloc: imageCubit,
                  builder: (context, state) {
                    var images = state.imagesDisplay;
                    return images?.isNotEmpty != true
                        ? const SizedBox()
                        : CarouselSlider.builder(
                            carouselController: carouselController,
                            itemCount: images!.length,
                            itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) {
                              var m = images[itemIndex];

                              return Hero(
                                tag: m.url!,
                                child: ClipRRect(
                                  child: PhotoView(
                                    initialScale:
                                        PhotoViewComputedScale.covered,
                                    backgroundDecoration: const BoxDecoration(
                                        color: Colors.transparent),
                                    imageProvider:
                                        CachedNetworkImageProvider(m.url!),
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              height: context.height,
                              aspectRatio: context.height / context.width,
                              viewportFraction: 1,
                              initialPage: index,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: false,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.25,
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (index, reason) {
                                if (reason !=
                                    CarouselPageChangedReason.controller) {
                                  setState(() {
                                    this.index = index;
                                  });
                                }
                                if (index > images.length - 6) {
                                  imageCubit.fetchImages(
                                      page: imageCubit.page + 1);
                                }
                              },
                            ),
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
            Positioned(
              top: 8.sw + context.mediaQueryPadding.top,
              right: horizPadding,
              child: WidgetFloatIconButton(
                onTap: () {
                  appHaptic();
                  saveNetworkImage(images[index].url!);
                },
                isSmallSize: false,
                icon: 'cloud-download',
                color: Colors.white,
              ),
            ),
            Positioned(
              bottom: context.mediaQueryPadding.bottom,
              left: 12.sw,
              right: 12.sw,
              height: 110.sw - context.mediaQueryPadding.bottom,
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WidgetFloatIconButton(
                      onTap: () {
                        appHaptic();
                        final box = context.findRenderObject() as RenderBox?;
                        Share.share(
                          stringShareImage(m.url),
                          subject: 'Share to you this image',
                          sharePositionOrigin:
                              box!.localToGlobal(Offset.zero) & box.size,
                        );
                      },
                      color: Colors.white,
                      icon: 'share',
                      isSmallSize: false,
                      padding: EdgeInsets.all(12.sw),
                    ),
                    IconButton(
                      onPressed: () {
                        appHaptic();
                        appOpenBottomSheet(WidgetUseImage(m: m, url: m.url!));
                      },
                      color: appColorPrimary,
                      icon: CircleAvatar(
                        backgroundColor: appColorPrimary,
                        radius: 36.sw,
                        child: WidgetAppSVG(
                          'slideshow',
                          width: 32.sw,
                          color: Colors.white,
                        ),
                      ),
                      iconSize: 32.sw,
                    ),
                    BlocBuilder<FavoriteCubit, FavoriteState>(
                      bloc: favoriteCubit,
                      builder: (context, state) {
                        return WidgetFloatIconButton(
                          onTap: () {
                            appHaptic();
                            if (state.isFavorited(m)) {
                              favoriteCubit.removeToFavorite(m);
                            } else {
                              favoriteCubit.addToFavorite(m);
                            }
                          },
                          icon: 'like',
                          color: state.isFavorited(m)
                              ? appColorPrimary
                              : Colors.white,
                          isSmallSize: false,
                          padding: EdgeInsets.all(12.sw),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageViewScreen extends StatefulWidget {
  final List<CivitaiImage> images;
  final int index;
  const ImageViewScreen({super.key, required this.images, required this.index});

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  late CarouselController carouselController = CarouselController();
  late List<CivitaiImage> images = widget.images;
  late int index = widget.index;

  CivitaiImage get m => images.length > index ? images[index] : CivitaiImage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorBackground,
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            images.isEmpty
                ? const SizedBox()
                : CarouselSlider.builder(
                    carouselController: carouselController,
                    itemCount: images.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) {
                      var m = images[itemIndex];

                      return Hero(
                        tag: m.url!,
                        child: ClipRRect(
                          child: PhotoView(
                            initialScale: PhotoViewComputedScale.covered,
                            backgroundDecoration:
                                const BoxDecoration(color: Colors.transparent),
                            imageProvider: CachedNetworkImageProvider(m.url!),
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: context.height,
                      aspectRatio: context.height / context.width,
                      viewportFraction: 1,
                      initialPage: index,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: false,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.25,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) {
                        if (reason != CarouselPageChangedReason.controller) {
                          setState(() {
                            this.index = index;
                          });
                        }
                      },
                    )),
            Positioned(
              top: 8.sw + context.mediaQueryPadding.top,
              left: horizPadding,
              child: const WidgetFloatButtonBack(),
            ),
            Positioned(
              top: 8.sw + context.mediaQueryPadding.top,
              right: horizPadding,
              child: WidgetFloatIconButton(
                onTap: () {
                  appHaptic();
                  saveNetworkImage(widget.images[index].url!);
                },
                isSmallSize: false,
                icon: 'cloud-download',
                color: Colors.white,
              ),
            ),
            Positioned(
              bottom: context.mediaQueryPadding.bottom,
              left: 12.sw,
              right: 12.sw,
              height: 110.sw - context.mediaQueryPadding.bottom,
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WidgetFloatIconButton(
                      onTap: () {
                        appHaptic();
                        final box = context.findRenderObject() as RenderBox?;
                        Share.share(
                          stringShareImage(m.url),
                          subject: 'Share to you this image',
                          sharePositionOrigin:
                              box!.localToGlobal(Offset.zero) & box.size,
                        );
                      },
                      color: Colors.white,
                      icon: 'share',
                      isSmallSize: false,
                      padding: EdgeInsets.all(12.sw),
                    ),
                    IconButton(
                      onPressed: () {
                        appHaptic();
                        appOpenBottomSheet(WidgetUseImage(m: m, url: m.url!));
                      },
                      color: appColorPrimary,
                      icon: CircleAvatar(
                        backgroundColor: appColorPrimary,
                        radius: 36.sw,
                        child: WidgetAppSVG(
                          'slideshow',
                          width: 32.sw,
                          color: Colors.white,
                        ),
                      ),
                      iconSize: 32.sw,
                    ),
                    BlocBuilder<FavoriteCubit, FavoriteState>(
                      bloc: favoriteCubit,
                      builder: (context, state) {
                        return WidgetFloatIconButton(
                          onTap: () {
                            appHaptic();
                            if (state.isFavorited(m)) {
                              favoriteCubit.removeToFavorite(m);
                            } else {
                              favoriteCubit.addToFavorite(m);
                            }
                          },
                          icon: 'like',
                          color: state.isFavorited(m)
                              ? appColorPrimary
                              : Colors.white,
                          isSmallSize: false,
                          padding: EdgeInsets.all(12.sw),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
