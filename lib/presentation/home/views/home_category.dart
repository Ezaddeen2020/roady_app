// import 'package:fdelux_source_neytrip/presentation/home/views/new/data.dart';
// import 'package:fdelux_source_neytrip/presentation/home/views/new/widgets/app_bar_widget.dart';
// import 'package:fdelux_source_neytrip/presentation/home/views/new/widgets/featured_section_widget.dart';
// import 'package:fdelux_source_neytrip/presentation/home/views/new/widgets/food_categories_widget.dart';
// import 'package:fdelux_source_neytrip/presentation/home/views/new/widgets/restaurant_card_widget.dart';
// import 'package:fdelux_source_neytrip/presentation/home/views/new/widgets/search_bar_widget.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final String _selectedLocation = 'Thuis';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 229, 237, 244),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Positioned.fill(
//               child: CustomScrollView(
//                 slivers: [
//                   const SliverToBoxAdapter(
//                     child: SizedBox(height: 160),
//                   ),

//                   const SliverToBoxAdapter(
//                     child: FoodCategoriesWidget(categories: AppData.foodCategories),
//                   ),

//                   const SliverToBoxAdapter(
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                       child: Text(
//                         'Bekende winkels',
//                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),

//                   // ===== GridView أفقي بثلاث صفوف =====
//                   SliverToBoxAdapter(
//                     child: SizedBox(
//                       height: 450, // ارتفاع الصندوق الذي يحوي 3 صفوف
//                       child: GridView.builder(
//                         scrollDirection: Axis.horizontal,
//                         physics: const BouncingScrollPhysics(),
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 3,        // عدد الصفوف = 3
//                           mainAxisSpacing: 12,      // مسافة بين الأعمدة
//                           crossAxisSpacing: 12,     // مسافة بين الصفوف
//                           childAspectRatio: 1.8,    // اضبطناها لتناسب العرض/الارتفاع
//                         ),
//                         itemCount: AppData.restaurants.length,
//                         itemBuilder: (context, index) {
//                           return RestaurantCard(
//                             restaurant: AppData.restaurants[index],
//                             width: 260, // عرض مقترح لكل كارد داخل الـ grid
//                           );
//                         },
//                       ),
//                     ),
//                   ),

//                   const SliverToBoxAdapter(
//                     child: FeaturedSection(),
//                   ),

//                   const SliverToBoxAdapter(
//                     child: SizedBox(height: 40),
//                   ),
//                 ],
//               ),
//             ),

//             // AppBar
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 color: const Color(0xFFF8F9FA),
//                 padding: const EdgeInsets.all(20),
//                 child: AppBarWidget(selectedLocation: _selectedLocation),
//               ),
//             ),

//             // Search Bar
//             Positioned(
//               top: 100,
//               left: 20,
//               right: 20,
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 10,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: const SearchBarWidget(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:fdelux_source_neytrip/common/app_colors.dart';
// import 'package:fdelux_source_neytrip/common/app_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';

// class HomeCategory extends StatelessWidget {
//   const HomeCategory({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16),
//           child: Text(
//             'Categories',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//               color: AppColors.textPrimary,
//             ),
//           ),
//         ),
//         const Gap(16),
//         SizedBox(
//           height: 40,
//           child: ListView.builder(
//             itemCount: AppConstants.categories.length,
//             scrollDirection: Axis.horizontal,
//             physics: const BouncingScrollPhysics(),
//             padding: const EdgeInsets.only(right: 16),
//             itemBuilder: (context, index) {
//               final category = AppConstants.categories[index];
//               return Padding(
//                 padding: EdgeInsets.only(
//                   left: index == 0 ? 16 : 6,
//                   right: index == AppConstants.categories.length - 1 ? 16 : 6,
//                 ),
//                 child: Chip(
//                   label: Text(category),
//                   backgroundColor: Colors.white,
//                   side: BorderSide.none,
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
