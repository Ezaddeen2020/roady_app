import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:fdelux_source_neytrip/common/app_assets.dart';
import 'package:fdelux_source_neytrip/common/widgets/custom_icon_button.dart';
import 'package:fdelux_source_neytrip/data/models/saved_destination_model.dart';
import 'package:fdelux_source_neytrip/presentation/saved_destinations/bloc/saved_destinations_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SavedDestinationItem extends StatelessWidget {
  final SavedDestinationModel item;

  const SavedDestinationItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/destinations/${item.id}');
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ExtendedImage.network(
                item.cover, 
                fit: BoxFit.cover,
                loadStateChanged: (ExtendedImageState state) {
                  switch (state.extendedImageLoadState) {
                    case LoadState.loading:
                      return const Center(child: CircularProgressIndicator());
                    case LoadState.completed:
                      return state.completedWidget;
                    case LoadState.failed:
                      return Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      );
                    default:
                      return Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.image, color: Colors.grey),
                        ),
                      );
                  }
                },
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: CustomIconButton(
              icon: AppAssets.icons.archive.remove,
              onTap: () {
                context.read<SavedDestinationsBloc>().add(
                  RemoveSavedDestinationEvent(destinationId: item.id),
                );
              },
            ),
          ),
          Positioned(
            left: 16,
            bottom: 16,
            right: 16,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white30,
                  ),
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text(
                    item.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}