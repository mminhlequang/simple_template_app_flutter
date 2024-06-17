// import 'package:app/src/presentation/home/cubit/favorite_cubit.dart';
// import 'package:app/src/presentation/home/cubit/favorite_model_cubit.dart';
// import 'package:app/src/presentation/home/cubit/model_cubit.dart';
// import 'package:app/src/presentation/widgets/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:internal_core/internal_core.dart';
// import 'package:app/src/constants/constants.dart';
// import 'package:app/src/presentation/home/widgets/widget_image_item.dart';
// import 'package:app/src/utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// class WidgetImagesByModel extends StatefulWidget {
//   const WidgetImagesByModel({super.key});

//   @override
//   State<WidgetImagesByModel> createState() => _WidgetImagesByModelState();
// }

// class _WidgetImagesByModelState extends State<WidgetImagesByModel> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ModelCubit, ModelState>(
//         bloc: modelCubit,
//         builder: (context, state) {
//           var images = state.imagesDisplay;
//           var m = state.model!;
//           return Scaffold(
//             backgroundColor: appColorBackground,
//             body: Stack(
//               alignment: Alignment.topLeft,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(
//                       horizPadding + 24.sw + 20.sw + 4.sw,
//                       context.mediaQueryPadding.top + 8,
//                       24.sw + 24.sw * 4,
//                       4),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         m.name ?? "",
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: w600TextStyle(fontSize: 18.sw),
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             "👏 ",
//                             style: TextStyle(
//                               fontSize: 12.sw,
//                             ),
//                           ),
//                           Text(
//                             m.stats?.downloadCount?.toString() ?? "-",
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: w500TextStyle(fontSize: 12.sw),
//                           ),
//                           Text(
//                             "   👍 ",
//                             style: TextStyle(
//                               fontSize: 12.sw,
//                             ),
//                           ),
//                           Text(
//                             m.stats?.thumbsUpCount?.toString() ?? "-",
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: w500TextStyle(fontSize: 12.sw),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 WidgetLoadMoreCallbackBuilder(
//                   callback: () async {
//                     await modelCubit.fetchImages(page: modelCubit.page + 1);
//                   },
//                   heighStartLoad: AppPrefs.instance.isGridView
//                       ? context.height / 1.5
//                       : context.height,
//                   builder:
//                       (bool isPerformingRequest, ScrollController controller) {
//                     return BlocBuilder<FavoriteCubit, FavoriteState>(
//                       bloc: favoriteCubit,
//                       builder: (context, state) {
//                         if (AppPrefs.instance.isGridView) {
//                           return MasonryGridView.count(
//                             addAutomaticKeepAlives: false,
//                             controller: controller,
//                             padding: EdgeInsets.fromLTRB(
//                                 horizPadding,
//                                 12.sw + context.mediaQueryPadding.top + 50,
//                                 horizPadding,
//                                 12.sw),
//                             crossAxisCount: crossAxisCount,
//                             mainAxisSpacing: 8.sw,
//                             crossAxisSpacing: 8.sw,
//                             itemCount: images == null
//                                 ? shimmerItemCount
//                                 : images.length,
//                             itemBuilder: (context, index) {
//                               var m = images?[index];
//                               return images == null
//                                   ? AspectRatio(
//                                       aspectRatio: images == null
//                                           ? doubleInRange(0.6, 1.2)
//                                           : m!.ratio,
//                                       child: WidgetAppShimmer(
//                                         borderRadius:
//                                             BorderRadius.circular(12.sw),
//                                       ),
//                                     )
//                                   : WidgetImageItem(
//                                       index: index,
//                                       m: m!,
//                                       images: images,
//                                       isExploreList: true,
//                                     );
//                             },
//                           );
//                         }
//                         return ListView.separated(
//                             controller: controller,
//                             padding: EdgeInsets.fromLTRB(
//                                 horizPadding,
//                                 12.sw + context.mediaQueryPadding.top + 50,
//                                 horizPadding,
//                                 12.sw),
//                             itemBuilder: (_, index) {
//                               var m = images?[index];
//                               return images == null
//                                   ? AspectRatio(
//                                       aspectRatio: images == null
//                                           ? doubleInRange(0.6, 1.2)
//                                           : m!.ratio,
//                                       child: WidgetAppShimmer(
//                                         borderRadius:
//                                             BorderRadius.circular(12.sw),
//                                       ),
//                                     )
//                                   : WidgetImageItem(
//                                       index: index,
//                                       m: m!,
//                                       images: images,
//                                       isExploreList: true,
//                                     );
//                             },
//                             separatorBuilder: (_, index) =>
//                                 SizedBox(height: 12.sw),
//                             itemCount: images == null
//                                 ? shimmerItemCount
//                                 : images.length);
//                       },
//                     );
//                   },
//                 ),
//                 Positioned(
//                   top: 8.sw + context.mediaQueryPadding.top,
//                   left: horizPadding,
//                   right: horizPadding,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const WidgetFloatButtonBack(),
//                       const Spacer(),
//                       SizedBox(
//                         width: 8.sw 
//                       ),
                       
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         });
//   }
// }
