// widgets/food_categories_widget.dart
import 'package:flutter/material.dart';
import '../model/models.dart';
import '../classes/constants.dart';

class CategoryItem extends StatelessWidget {
  final FoodCategory category;
  final double imageSize;
  final double containerSize;

  const CategoryItem({
    super.key,
    required this.category,
    this.imageSize = 80,
    this.containerSize = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // زيادة العرض قليلاً
      margin: const EdgeInsets.only(left: 5, right: 5), // مسافة أفضل
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // حاوية الصورة - بدون لون خلفية
          Container(
            width: containerSize,
            height: containerSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              child: Padding(
                padding: const EdgeInsets.all(8.0), // مسافة داخلية
                child: Image.asset(
                  category.imagePath,
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.contain,
                  // معالج الأخطاء
                  errorBuilder: (context, error, stackTrace) {
                    debugPrint('خطأ في تحميل الصورة: ${category.imagePath}');
                    return Icon(
                      Icons.fastfood,
                      size: imageSize * 0.7,
                      color: Colors.grey[400],
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // النص
          Text(
            category.label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
            maxLines: 2, // السماح بسطرين
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class FoodCategoriesWidget extends StatelessWidget {
  final List<FoodCategory> categories;
  final double imageSize;
  final double containerSize;
  final double height;

  const FoodCategoriesWidget({
    super.key,
    required this.categories,
    this.imageSize = 50,
    this.containerSize = 80,
    this.height = 130, // زيادة الارتفاع
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        physics: const BouncingScrollPhysics(), // تأثير ارتداد سلس
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryItem(
            category: categories[index],
            imageSize: imageSize,
            containerSize: containerSize,
          );
        },
      ),
    );
  }
}
