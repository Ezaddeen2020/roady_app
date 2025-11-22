import 'package:fdelux_source_neytrip/common/app_assets.dart';
import 'package:fdelux_source_neytrip/common/app_colors.dart';
import 'package:fdelux_source_neytrip/common/blocs/auth/auth_bloc.dart';
import 'package:fdelux_source_neytrip/common/widgets/custom_icon_button.dart';
import 'package:fdelux_source_neytrip/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        UserModel? user;
        if (state is Authenticated) {
          user = state.user;
        }
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              AppAssets.images.logo,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            user?.city ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
          ),
          subtitle: Text(
            user?.address ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          trailing: CustomIconButton(
            icon: AppAssets.icons.notification,
            onTap: () {},
          ),
        );
      },
    );
  }
}
