import 'package:fdelux_source_neytrip/presentation/home/views/new/widgets/app_bar_widget.dart';
import 'package:fdelux_source_neytrip/presentation/home/views/new/widgets/featured_section_widget.dart';
import 'package:fdelux_source_neytrip/presentation/home/views/new/widgets/food_categories_widget.dart';
import 'package:fdelux_source_neytrip/presentation/home/views/new/widgets/restaurant_card_widget.dart';
import 'package:fdelux_source_neytrip/presentation/home/views/new/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import '../classes/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _selectedLocation = 'Thuis';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 237, 244),
      body: SafeArea(
        child: Stack(
          children: [
            // المحتوى الرئيسي في الخلفية
            Positioned.fill(
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 160),
                  ),

                  // فئات الطعام
                  const SliverToBoxAdapter(
                    child: FoodCategoriesWidget(categories: AppData.foodCategories),
                  ),
                  // قائمة الفلاتر الأفقية
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: AppData.filterOptions.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (_, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.teal, width: 1.2),
                            ),
                            child: Text(
                              AppData.filterOptions[index],
                              style: const TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(
                    child: SizedBox(height: 16),
                  ),

                  // قسم Bekende winkels مع التمرير الأفقي
                  const SliverToBoxAdapter(
                    child: SectionTitle(title: 'Bekende winkels'),
                  ),

                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 440, // ارتفاع كافٍ لـ 3 صفوف من الكاردات
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: (AppData.restaurants.length / 3).ceil(),
                        itemBuilder: (context, columnIndex) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.8, // 90% من عرض الشاشة
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            child: Column(
                              children: [
                                // الصف الأول
                                if (columnIndex * 3 < AppData.restaurants.length)
                                  RestaurantCard(
                                    restaurant: AppData.restaurants[columnIndex * 3],
                                  ),
                                const SizedBox(height: 0.1),

                                // الصف الثاني
                                if (columnIndex * 3 + 1 < AppData.restaurants.length)
                                  RestaurantCard(
                                    restaurant: AppData.restaurants[columnIndex * 3 + 1],
                                  ),
                                const SizedBox(height: 0.1),

                                // الصف الثالث
                                if (columnIndex * 3 + 2 < AppData.restaurants.length)
                                  RestaurantCard(
                                    restaurant: AppData.restaurants[columnIndex * 3 + 2],
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(
                    child: SizedBox(height: 16),
                  ),

                  // القسم المميز
                  const SliverToBoxAdapter(
                    child: FeaturedSection(),
                  ),

                  const SliverToBoxAdapter(
                    child: SizedBox(height: 20),
                  ),
                ],
              ),
            ),

            // الـ AppBar في الأعلى
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: const Color(0xFFF8F9FA),
                padding: const EdgeInsets.all(20),
                child: AppBarWidget(selectedLocation: _selectedLocation),
              ),
            ),

            // الـ SearchBar في المنتصف
            Positioned(
              top: 100, // يبدأ من أسفل الـ AppBar
              left: 20,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const SearchBarWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
