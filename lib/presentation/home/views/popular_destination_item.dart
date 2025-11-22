// import 'dart:ui';

// import 'package:extended_image/extended_image.dart';
// import 'package:fdelux_source_neytrip/common/app_assets.dart';
// import 'package:fdelux_source_neytrip/common/app_colors.dart';
// import 'package:fdelux_source_neytrip/data/models/destination_model.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:go_router/go_router.dart';

// class PopularDestinationItem extends StatelessWidget {
//   final DestinationModel destination;
//   final int index;
//   final int lastIndex;

//   const PopularDestinationItem({
//     super.key,
//     required this.destination,
//     required this.index,
//     required this.lastIndex,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         context.push('/destinations/${destination.id}');
//       },
//       child: Container(
//         padding: EdgeInsets.only(
//           left: index == 0 ? 16 : 8,
//           right: index == lastIndex ? 16 : 8,
//         ),
//         width: 240,
//         child: Stack(
//           children: [
//             ConstrainedBox(
//               constraints: const BoxConstraints.expand(),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: ExtendedImage.network(
//                   destination.cover,
//                   fit: BoxFit.cover,
//                   loadStateChanged: (ExtendedImageState state) {
//                     switch (state.extendedImageLoadState) {
//                       case LoadState.loading:
//                         return const Center(child: CircularProgressIndicator());
//                       case LoadState.completed:
//                         return state.completedWidget;
//                       case LoadState.failed:
//                         return Container(
//                           color: Colors.grey[300],
//                           child: const Center(
//                             child: Icon(Icons.broken_image, color: Colors.grey),
//                           ),
//                         );
//                       default:
//                         return Container(
//                           color: Colors.grey[300],
//                           child: const Center(
//                             child: Icon(Icons.image, color: Colors.grey),
//                           ),
//                         );
//                     }
//                   },
//                 ),
//               ),
//             ),
//             Positioned(
//               left: 8,
//               right: 8,
//               bottom: 8,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(16),
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(
//                     sigmaX: 5,
//                     sigmaY: 5,
//                     tileMode: TileMode.clamp,
//                   ),
//                   child: Container(
//                     width: MediaQuery.sizeOf(context).width * 0.6,
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: AppColors.textThin.withAlpha(50),
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 destination.name,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const Gap(6),
//                               Row(
//                                 children: [
//                                   ImageIcon(
//                                     AssetImage(AppAssets.icons.location),
//                                     size: 12,
//                                     color: Colors.white70,
//                                   ),
//                                   const Gap(4),
//                                   Expanded(
//                                     child: Text(
//                                       destination.location.address,
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: const TextStyle(
//                                         color: Colors.white70,
//                                         fontSize: 11,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 16.0),
//                         ImageIcon(
//                           AssetImage(AppAssets.icons.arrow.right),
//                           size: 20,
//                           color: AppColors.textThin,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
