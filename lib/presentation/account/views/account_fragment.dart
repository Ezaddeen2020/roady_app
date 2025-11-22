import 'package:extended_image/extended_image.dart';
import 'package:fdelux_source_neytrip/common/app_assets.dart';
import 'package:fdelux_source_neytrip/common/app_colors.dart';
import 'package:fdelux_source_neytrip/common/blocs/auth/auth_bloc.dart';
import 'package:fdelux_source_neytrip/common/utils/snackbar_util.dart';
import 'package:fdelux_source_neytrip/common/widgets/group_list_tile_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'account_tile.dart';

class AccountFragment extends StatelessWidget {
  const AccountFragment({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(LoggedOutEvent());
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: AppBar(
            forceMaterialTransparency: true,
            backgroundColor: AppColors.background,
            title: const Text(
              'Account',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColors.textPrimary,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () => context.push('/settings'),
                icon: ImageIcon(AssetImage(AppAssets.icons.settings), size: 24),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: SizedBox(
                  width: 140,
                  height: 140,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: DecoratedBox(
                          position: DecorationPosition.foreground,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 4),
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                if (state is Authenticated) {
                                  return ExtendedImage.network(
                                    state.user.photoUrl ?? '',
                                    fit: BoxFit.cover,
                                    loadStateChanged: (ExtendedImageState imageState) {
                                      switch (imageState.extendedImageLoadState) {
                                        case LoadState.loading:
                                          return const Center(child: CircularProgressIndicator());
                                        case LoadState.completed:
                                          return imageState.completedWidget;
                                        case LoadState.failed:
                                          return Container(
                                            color: Colors.grey[300],
                                            child: const Icon(Icons.person, color: Colors.grey),
                                          );
                                        default:
                                          return Container(
                                            color: Colors.grey[300],
                                            child: const Icon(Icons.person, color: Colors.grey),
                                          );
                                      }
                                    },
                                  );
                                }
                                return ImageIcon(
                                  AssetImage(AppAssets.icons.user.profile),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton.filled(
                          style: IconButton.styleFrom(
                            fixedSize: const Size(30, 30),
                            padding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () =>
                              SnackbarUtil.notImplementedYet(context),
                          icon: ImageIcon(
                            AssetImage(AppAssets.icons.edit),
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(40),
              GroupListTileSection(
                children: [
                  AccountItem(
                    icon: AppAssets.icons.user.profile,
                    label: 'Profile Details',
                    onTap: () => context.push('/profile'),
                  ),
                  AccountItem(
                    icon: AppAssets.icons.password,
                    label: 'Password',
                    onTap: () => SnackbarUtil.notImplementedYet(context),
                  ),
                ],
              ),
              const Gap(20),
              GroupListTileSection(
                children: [
                  AccountItem(
                    icon: AppAssets.icons.archive.outline,
                    label: 'Favorites',
                    onTap: () {
                      context.push('/destinations/saved');
                    },
                  ),
                  AccountItem(
                    icon: AppAssets.icons.journey,
                    label: 'Journey',
                    onTap: () => SnackbarUtil.notImplementedYet(context),
                  ),
                ],
              ),
              const Gap(20),
              GroupListTileSection(
                children: [
                  AccountItem(
                    icon: AppAssets.icons.logout,
                    label: 'Logout',
                    onTap: () => _showLogoutDialog(context),
                    nextIcon: false,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}