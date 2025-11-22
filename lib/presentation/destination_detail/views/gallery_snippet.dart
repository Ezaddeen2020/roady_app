import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:fdelux_source_neytrip/common/app_constants.dart';
import 'package:flutter/material.dart';

class GallerySnippet extends StatelessWidget {
  static const _count = 4;

  final List<String> images;
  const GallerySnippet({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.black.withAlpha(100)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            // spacing: 8,
            children: List.generate(_count, (index) {
              final url = images[index];
              return SizedBox(
                width: 70,
                height: 70,
                child: index == 3
                    ? _MoreGallery(url: url, more: images.length - _count + 1)
                    : _GalleryItem(url: url),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _GalleryItem extends StatelessWidget {
  const _GalleryItem({required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: ExtendedImage.network(
        url,
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
                  child: Icon(Icons.image_not_supported, size: 20, color: Colors.grey),
                ),
              );
            default:
              return Container(
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.image, size: 20, color: Colors.grey),
                ),
              );
          }
        },
      ),
    );
  }
}

class _MoreGallery extends StatelessWidget {
  const _MoreGallery({required this.url, required this.more});
  final String url;
  final int more;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ExtendedImage.network(
            url,
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
                      child: Icon(Icons.image_not_supported, color: Colors.grey),
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
          ColoredBox(color: Colors.black.withValues(alpha: 0.6)),
          Center(
            child: Text(
              '+$more',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}