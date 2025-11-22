// import 'package:fdelux_source_neytrip/common/app_colors.dart';
// import 'package:fdelux_source_neytrip/presentation/home/bloc/popular_destination_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';

// import 'home_header.dart';
// import 'home_search.dart';
// import 'popular_destination.dart';

// class HomeFragment extends StatelessWidget {
//   const HomeFragment({super.key});

//   Future<void> _onScrollRefresh(BuildContext context) async {
//     context.read<PopularDestinationBloc>().add(
//       const RefreshPopularDestinationsEvent(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator.adaptive(
//       displacement: 10,
//       onRefresh: () => _onScrollRefresh(context),
//       child: ListView(
//         physics: const BouncingScrollPhysics(),
//         padding: const EdgeInsets.only(top: 40, bottom: 100),
//         children: const [
//           HomeHeader(),
//           Gap(8),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: Text(
//               'Ready to go to next\nbeautiful place?',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 30,
//                 color: AppColors.textPrimary,
//               ),
//             ),
//           ),
//           Gap(20),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: HomeSearch(),
//           ),
//           Gap(20),
//           HomeCategory(),
//           Gap(24),
//           PopularDestination(),
//           Gap(20),
//         ],
//       ),
//     );
//   }
// }
