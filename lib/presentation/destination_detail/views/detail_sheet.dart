import 'package:fdelux_source_neytrip/common/app_assets.dart';
import 'package:fdelux_source_neytrip/common/app_colors.dart';
import 'package:fdelux_source_neytrip/common/utils/number_util.dart';
import 'package:fdelux_source_neytrip/data/models/destination_model.dart';
import 'package:fdelux_source_neytrip/presentation/destination_detail/views/sections/best_time_to_visit_section.dart';
import 'package:fdelux_source_neytrip/presentation/destination_detail/views/sections/category_section.dart';
import 'package:fdelux_source_neytrip/presentation/destination_detail/views/sections/image_sources_section.dart';
import 'package:fdelux_source_neytrip/presentation/destination_detail/views/sections/location_section.dart';
import 'package:fdelux_source_neytrip/presentation/destination_detail/views/sections/popular_activities_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DetailSheet extends StatelessWidget {
  final DestinationModel destination;

  const DetailSheet({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      shouldCloseOnMinExtent: false,
      initialChildSize: 0.35,
      minChildSize: 0.35,
      maxChildSize: 1,
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(16),
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        destination.name,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade50,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          ImageIcon(
                            AssetImage(AppAssets.icons.star),
                            size: 15,
                            color: Colors.amber,
                          ),
                          const Gap(8),
                          Text(
                            '${destination.rating}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '/${NumberUtil.compact(destination.reviewCount!)}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(8),
              LocationSection(location: destination.location),
              const Gap(10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Divider(color: AppColors.textThin, height: 1),
              ),
              const Gap(20),
              CategorySection(categories: destination.category!),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  destination.description!,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const Gap(16),
              BestTimeToVisitSection(
                bestTimeToVisit: destination.bestTimeToVisit!,
              ),
              const Gap(20),
              PopularActivitiesSection(activities: destination.activities!),
              const Gap(20),
              ImageSourcesSection(sources: destination.imageSources!),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }
}
