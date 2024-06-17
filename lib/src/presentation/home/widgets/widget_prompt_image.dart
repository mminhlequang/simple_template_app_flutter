// import 'package:app/src/utils/utils.dart';
// import 'package:internal_core/internal_core.dart';
// import 'package:app/src/constants/app_sizes.dart';
// import 'package:app/src/network_resources/civitai/model/model.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class WidgetPromptImage extends StatelessWidget {
//   final CivitaiImage m;
//   const WidgetPromptImage({super.key, required this.m});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.vertical(
//             top: Radius.circular(16.sw),
//           ),
//           color: appColorBackground),
//       padding: EdgeInsets.only(bottom: context.mediaQueryPadding.bottom + 12),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(
//               height: 8.sw,
//             ),
//             Center(
//               child: Container(
//                 width: 55.sw,
//                 height: 4.5.sw,
//                 decoration: BoxDecoration(
//                     color: appColorText.withOpacity(.1),
//                     borderRadius: BorderRadius.circular(99)),
//               ),
//             ),
//             SizedBox(
//               height: 12.sw,
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.sw),
//               child: Text(
//                 'Meta image'.tr(),
//                 style: w400TextStyle(fontSize: 16.sw),
//               ),
//             ),
//             SizedBox(
//               height: 12.sw,
//             ),
//             Container(
//               height: 1,
//               color: appColorElement,
//             ),
//             SizedBox(
//               height: 8.sw,
//             ),
//             if (m.meta?.model != null) buildInfo("model", m.meta?.model ?? ""),
//             // buildInfo("steps", m.meta?.steps?.toString() ?? ""),
//             // if (m.meta?.sampler != null)
//             //   buildInfo("sampler", m.meta?.sampler ?? ""),
//             // if (m.meta?.clipSkip != null)
//             //   buildInfo("clipSkip", m.meta?.clipSkip ?? ""),
//             buildInfo("prompt", m.meta?.prompt ?? ""),
//             buildInfo("negativePrompt", m.meta?.negativePrompt ?? ""),
//             const SizedBox(height: 4),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildInfo(String label, String data) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24.sw),
//           child: Text(
//             label.tr(),
//             style: w400TextStyle(fontSize: 12.sw),
//           ),
//         ),
//         SizedBox(
//           height: 4.sw,
//         ),
//         Row(
//           children: [
//             SizedBox(
//               width: 16.sw,
//             ),
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: appColorElement,
//                     borderRadius: BorderRadius.circular(12.sw)),
//                 padding: EdgeInsets.all(12.sw),
//                 child: Text(data),
//               ),
//             ),
//             WidgetRippleButton(
//               onTap: () {
//                 appHaptic();
//                 Clipboard.setData(ClipboardData(text: data));
//                 showSnackBar(msg: "Coppied!".tr());
//               },
//               color: Colors.transparent,
//               child: Padding(
//                 padding:
//                     EdgeInsets.symmetric(vertical: 14.sw, horizontal: 16.sw),
//                 child: WidgetAppSVG(
//                   'copy',
//                   width: 20.sw,
//                   height: 20.sw,
//                   color: appColorText,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 16.sw,
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 8.sw,
//         ),
//       ],
//     );
//   }
// }
