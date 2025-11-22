import 'package:extended_image/extended_image.dart';
import 'package:fdelux_source_neytrip/common/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key, required this.images, required this.title});
  final String title;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title),
        titleSpacing: 0,
        centerTitle: true,
        leading: const CustomBackButton(),
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
      ),
      body: MasonryGridView.count(
        itemCount: images.length,
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final imageURL = images[index];
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      InteractiveViewer(
                        child: ExtendedImage.network(
                          imageURL,
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
                      Positioned(
                        bottom: 60,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: CloseButton(
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: ExtendedImage.network(
              imageURL,
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
          );
        },
      ),
    );
  }
}