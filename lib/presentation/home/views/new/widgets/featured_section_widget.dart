// widgets/featured_section_widget.dart
import 'package:flutter/material.dart';

import '../classes/constants.dart';

class FeaturedSection extends StatelessWidget {
  const FeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Uitgelicht'),
        const Padding(
          padding: EdgeInsets.fromLTRB(
            AppConstants.defaultPadding,
            0,
            AppConstants.defaultPadding,
            12,
          ),
          child: Text(
            'Gesponsorde plaatsingen van onze partners',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
        ),
        Container(
          height: 160,
          margin: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            image: const DecorationImage(
              image: NetworkImage('https://images.unsplash.com/photo-1518791841217-8f162f1e1131'),
              fit: BoxFit.cover,
              // onError: (exception, stackTrace) {
              //   // Handle image loading error
              // },
            ),
          ),
          child: Stack(
            children: [
              const Positioned(
                top: 12,
                left: 12,
                child: Badge(
                  text: '-50% op geselecteerde items',
                  backgroundColor: AppColors.discountRed,
                ),
              ),
              const Positioned(
                bottom: 12,
                left: 12,
                child: Badge(
                  text: 'Beperkte trackinginfo',
                  backgroundColor: AppColors.primary,
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.favorite_outline, color: Colors.grey, size: 20),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.defaultPadding,
        AppConstants.smallPadding,
        AppConstants.defaultPadding,
        12,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class Badge extends StatelessWidget {
  final String text;
  final Color backgroundColor;

  const Badge({required this.text, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
