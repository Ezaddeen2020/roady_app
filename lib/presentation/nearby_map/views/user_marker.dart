import 'package:extended_image/extended_image.dart';
import 'package:fdelux_source_neytrip/common/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:fdelux_source_neytrip/common/app_assets.dart';

class UserMarker extends StatelessWidget {
  static const _width = 60.0 * 0.7;
  static const _height = 80.0 * 0.7;

  final LatLng point;
  final void Function(LatLng point) onTap;

  const UserMarker({super.key, required this.point, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is! Authenticated) {
          return const SizedBox.shrink();
        }
        return MarkerLayer(
          markers: [
            Marker(
              point: point,
              width: _width,
              height: _height,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () => onTap(point),
                child: Stack(
                  children: [
                    ClipOval(
                      child: ExtendedImage.network(
                        state.user.photoUrl ?? '',
                        width: _width,
                        height: _width,
                        fit: BoxFit.cover,
                        loadStateChanged: (ExtendedImageState state) {
                          switch (state.extendedImageLoadState) {
                            case LoadState.loading:
                              return const Center(child: CircularProgressIndicator());
                            case LoadState.completed:
                              return state.completedWidget;
                            case LoadState.failed:
                              return Container(
                                width: _width,
                                height: _width,
                                color: Colors.grey[300],
                                child: const Icon(Icons.person, color: Colors.grey),
                              );
                            default:
                              return Container(
                                width: _width,
                                height: _width,
                                color: Colors.grey[300],
                                child: const Icon(Icons.person, color: Colors.grey),
                              );
                          }
                        },
                      ),
                    ),
                    Image.asset(
                      AppAssets.images.marker.user,
                      width: _width,
                      height: _height,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}