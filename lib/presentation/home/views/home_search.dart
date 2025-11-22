// import 'package:fdelux_source_neytrip/common/app_assets.dart';
// import 'package:fdelux_source_neytrip/common/app_colors.dart';
// import 'package:fdelux_source_neytrip/common/widgets/custom_icon_button.dart';
// import 'package:flutter/material.dart';

// class HomeSearch extends StatelessWidget {
//   static const _borderRadius = BorderRadius.all(Radius.circular(16));

//   const HomeSearch({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       onTapOutside: (event) => FocusScope.of(context).unfocus(),
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: Colors.white,
//         isDense: true,
//         hintText: "Where do you wanna go?",
//         hintStyle: const TextStyle(
//           fontWeight: FontWeight.w400,
//           fontSize: 14,
//           color: Colors.black45,
//         ),
//         contentPadding: const EdgeInsets.all(0),
//         border: const OutlineInputBorder(),
//         enabledBorder: const OutlineInputBorder(
//           borderRadius: _borderRadius,
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: const OutlineInputBorder(
//           borderRadius: _borderRadius,
//           borderSide: BorderSide.none,
//         ),
//         prefixIcon: Padding(
//           padding: const EdgeInsets.all(4),
//           child: CustomIconButton(
//             onTap: () {},
//             icon: AppAssets.icons.search,
//             borderRadius: BorderRadius.all(Radius.circular(12)),
//           ),
//         ),
//         suffixIcon: Padding(
//           padding: const EdgeInsets.all(4),
//           child: CustomIconButton(
//             onTap: () {},
//             icon: AppAssets.icons.filter,
//             backgroundColor: AppColors.primary,
//             foregroundColor: Colors.white,
//             borderRadius: BorderRadius.all(Radius.circular(12)),
//           ),
//         ),
//       ),
//     );
//   }
// }
